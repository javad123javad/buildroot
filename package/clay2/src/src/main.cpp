
// SPDX-License-Identifier: MIT
/** @file main.cpp
 *
 * @brief The main asignment file
 *
 * COPYRIGHT NOTICE: (c) 2022 Javad Rahimi.  All rights reserved.
 */

#include "inc/repository.h"
#include <iostream>
#include <sstream>
#include <al.h>
#include <thread>
#include <mutex>
#include <signal.h>
#include <memory>

using namespace std;

#define AL_UNIX_FILE "/tmp/alunix.sock"
#define REPO_PATH "/tmp/clay_repo.txt"
static shared_ptr<repository> g_repo;
static mutex g_repo_mutex;

/**
 * @brief exec_cmd  Execute received command (stdin or IPC) on the repository
 * 
 * @param repo The main repository object
 * @param command The received command
 * @param out_value The result of the command.
 * @return int32_t 0 on success, negative values on failure
 */
int32_t exec_cmd(shared_ptr<repository> repo, std::string command, std::string &out_value)
{
    int fret = 0;
    string cmd, key, value;
    std::map<std::string, std::string>::iterator it;

    stringstream stream_buf(command);
    stream_buf >> cmd >> key >> value;

    g_repo_mutex.lock(); // Critical Section
    out_value.clear();
    if ("SET" == cmd)
    {

        fret = repo->set_data(key, value);
        if (0 == fret)
        {
            //    cout<<"OK"<<endl;
            out_value = "OK";
        }
        else
            cerr << "SET command has three arguments" << endl;
    }
    else if (cmd == "GET")
    {
        fret = repo->get_data(key, value, &it);
        if (0 == fret)
        {
            out_value = it->second;
        }
    }
    else if (cmd == "DELETE")
    {
        fret = repo->del_data(key);
        if (0 == fret)
        {
            out_value = "OK";
        }
    }
    else if (cmd == "QUIT")
    {
        out_value = "BYE";
        fret = -2;
    }
    else
    {
        out_value = "Invalid Command";

        fret = -1;
    }

    g_repo_mutex.unlock();
    return fret;
}

/**
 * @brief server_cb the callback function for the server. All IPC commands are handled here
 * @param payload   the payload of the message.
 */
void server_cb(cpayload *payload)
{

    if (strlen(payload->payload) > 0)
    {
        string value;
        exec_cmd(g_repo, string(payload->payload), value);
        al_write_sock(payload->cli_sock, value.c_str(), value.length());
    }
}
/**
 * @brief thr_cb    the thread callback function. Set up a UNIX socket and listen to it.
 */
void thr_cb()
{
    int32_t server_sock;
    int32_t fret;
    server_sock = al_srv_open_sock(SOCK_UNIX);
    fret = al_unix_srv_bind(server_sock, AL_UNIX_FILE);
    if (-1 == fret)
    {
        return;
    }
    fret = al_srv_listen_sock(server_sock, 4);
    if (-1 == fret)
    {
        perror("Listen");
        return;
    }

    fret = al_srv_serve_reqs(server_sock, server_cb);
}

/**
 * @brief h_signal    proper deleting the repository
 *
 * @param signo signal number
 */
void h_signal(int32_t signo)
{
    if (SIGINT == signo)
    {
        g_repo->close_file();
        exit(0);
    }
}
int main()
{
    int32_t fret = 0;
    g_repo = make_shared<repository>(REPO_PATH);
    string line;
    string value;
    
    /* Create a thread to handle the UNIX IPC server */
    std::thread ipc_thr(thr_cb);
    ipc_thr.detach();

    /* Handle kill signal */
    signal(SIGINT, h_signal);

    g_repo->open_file();

    while (1)
    {
        cout << "> ";
        getline(cin, line);
        fret = exec_cmd(g_repo, line, value);
        cout << value << endl;
        if (-2 == fret)
        {
            break;
        }
    }

    g_repo->close_file();
    return 0;
    }
