# imp_netman
Impeirum Drive network manager is an inteligent network manager, which constantly monitor network adapters and apply user defined shaping rules to it. 
## Build
imp_netman uses autohell to build the binary output. So, the instruction is straight forward:
```shell
./autogen.sh && configure && make
```
After successful compilation, the executable will be available in `src/imp_netman2`
## Configuration File
imp_netman needs a configuration file which describe rules per adapter. Each row in the configuration file declare a new rule for the adapter. The general structure of the configuration is as follows:

    <adapter name>  port  <port name>  speed  <least guaranteed speed>  ceil  <max allowable speed>  index  <rule index number>  prio  <rule priority>
For example:


    idtun port 22 speed 500 ceil 1000 index 10 prio 1
    idtun port 5000 speed 200 ceil 300 index 20 prio 1
    idtun port 6000 speed 300 ceil 3000 index 30 prio 2
    wg0   port 7000 speed 2500 ceil 4000 index 40 prio 1
    wg0   port 8000 speed 2500 ceil 4000 index 50 prio 1

## Execute
Simple run the `imp_Netman2` with the configuration file:
```shell
./imp_netman2 ./test.conf
```

