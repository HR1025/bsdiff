set(HOST "aarch64-linux")
set(CMAKE_C_COMPILER "${HOST}-gcc")
set(CMAKE_CXX_COMPILER "${HOST}-g++")
set(CMAKE_AR "${HOST}-ar")
set(CMAKE_RANLIB "${HOST}-ranlib")

# your node include (need modify), may be we need the node for toolchain ???
include_directories("/home/haorui/.node/node-v18.12.1-linux-x64/include/node")