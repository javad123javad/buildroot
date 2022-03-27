#ifndef REPOSITORY_H
#define REPOSITORY_H

#include <iostream>
#include <iterator>
#include <map>
#include <unistd.h>
#include <fstream>

typedef struct _db_map
{
    std::string key;
    std::string value;
}db_map_t;
/**
 * @brief The repository class, responsible for storing the key/values
 */
class repository
{
public: /* method */
    repository() = delete ;
    repository(std::string repo_name);

    int32_t open_file();
    int32_t close_file();
    int32_t set_data(std::string key, std::string value, bool sync = true);
    int32_t get_data(const std::string key, std::string &value, std::map<std::string, std::string>::iterator* it = nullptr);
    int32_t del_data(const std::string key);
    int32_t load_file_data();
    int32_t update_file();
    int32_t show_data();
private:// Methods

private:
    std::string repo_file_name;
    std::map<std::string, std::string> repo_data;
    std::ofstream repo_file;
    std::ifstream repo_file_read;
    bool is_db_loaded = false;




};

#endif // REPOSITORY_H
