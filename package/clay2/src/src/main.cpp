#include <iostream>
#include <sstream>
#include "inc/repository.h"
#include <al.h>
#include <thread>
#include <mutex>

using namespace std;

#define AL_UNIX_FILE        "/tmp/alunix.sock"
static repository *g_repo;
static mutex g_repo_mutex;

int32_t exec_cmd(repository * repo, std::string command, std::string& out_value)
{
    int fret = 0;
    string cmd, key, value;
    std::map<std::string, std::string>::iterator it;

    stringstream stream_buf(command);
    stream_buf >> cmd>>key>>value;

    g_repo_mutex.lock();//Critical Section

    if("SET" == cmd)
    {
        fret = repo->set_data(key, value);
        if(0 == fret)
        {
//            cout<<"OK"<<endl;
            out_value = "OK";

        }
    }
    else if (cmd == "GET")
    {
        fret = repo->get_data(key,value, &it);
        if(0 == fret)
        {
//            cout<< it->second<<endl;
            out_value = it->second;
        }
    }
    else if(cmd == "DELETE")
    {
        fret = repo->del_data(key);
        if(0 == fret)
        {
//            cout<<"OK"<<endl;
            out_value = "OK";
        }
    }
    else if(cmd == "QUIT")
    {
        out_value = "BYE";
        fret = -2;
    }
    else
    {
//        cerr<<"Illegal Command"<<endl;
        out_value = "Invalid Command";

        fret = -1;
    }

    g_repo_mutex.unlock();
    return fret;

}


void server_cb(cpayload *payload)
{

    if(strlen(payload->payload)>0)
    {
        string value;
    exec_cmd(g_repo,string(payload->payload), value);
//    fprintf(stderr,"Callback: cmd:%s key:%s value:%s\n", cmd.c_str(), key.c_str(), value.c_str());
    al_write_sock(payload->cli_sock, value.c_str(), value.length());
    }
}
void thr_cb()
{
    int32_t server_sock;
    int32_t fret;
    server_sock = al_srv_open_sock(SOCK_UNIX);
    fret = al_unix_srv_bind(server_sock, AL_UNIX_FILE);
    if(-1 == fret)
    {
        return ;
    }
    fret =  al_srv_listen_sock(server_sock,4);
    if(-1 == fret)
    {
        perror("Listen");
        return ;
    }

    fret = al_srv_serve_reqs(server_sock, server_cb);
}
int main()
{
    int32_t fret = 0;
    g_repo = new repository("/tmp/test_repo.txt");
    string line;
    string value;
    std::thread ipc_thr( thr_cb);
    ipc_thr.detach();

    g_repo->open_file();
    while (1) {
        cout<<"> ";
        getline(cin, line);
        fret = exec_cmd(g_repo,line, value);
        cout<<value<<endl;
        if(-2 == fret)
        {
            break;
        }
    }
    g_repo->close_file();
    delete g_repo;


}
