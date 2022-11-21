cmake_minimum_required(VERSION 3.15.0)

project(bsdiff)

set(SRCS)
set(INCS)

# for local build
if (NOT CMAKE_JS_VERSION)
    list(APPEND CMAKE_JS_INC "/home/haorui/.cmake-js/node-x64/v18.12.1/include/node")  # modify according to you environment
    list(APPEND CMAKE_JS_INC "/home/haorui/.node/node-v18.12.1-linux-x64/include/node")
    file(REMOVE_RECURSE ${CMAKE_CURRENT_SOURCE_DIR}/node_modules)
    find_program(NPM npm REQUIRED) # check if npm exist
    # nan adapter
    execute_process(COMMAND npm install nan WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
    list(APPEND CMAKE_JS_INC ${CMAKE_CURRENT_SOURCE_DIR}/node_modules/nan)
endif()

# collect source files
file(GLOB BZIP2_SRCS   "${CMAKE_CURRENT_SOURCE_DIR}/src/c/bzip2/*.c*")
file(GLOB BSPATCH_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/src/c/bspatch/*.c*")
file(GLOB BSPDIFF_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/src/c/bsdiff/*.c*")
file(GLOB MAIN_SRCS    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c*")
list(APPEND SRCS  
    ${BZIP2_SRCS}
    ${BSPATCH_SRCS}
    ${BSPDIFF_SRCS}
    ${MAIN_SRCS}
)

# collect include directory
list(APPEND INCS  
    ${CMAKE_CURRENT_SOURCE_DIR}/src/c/bzip2
    ${CMAKE_CURRENT_SOURCE_DIR}/src/c/bspatch
    ${CMAKE_CURRENT_SOURCE_DIR}/src/c/bsdiff
    ${CMAKE_CURRENT_SOURCE_DIR}/src/c
)
include_directories(${INCS})
include_directories(${CMAKE_JS_INC})

add_library(${PROJECT_NAME} SHARED ${MAIN_SRCS} ${CMAKE_JS_SRC})
set_target_properties(${PROJECT_NAME} PROPERTIES PREFIX "" SUFFIX ".node")
target_link_libraries(${PROJECT_NAME} ${CMAKE_JS_LIB})


# only for windows
if(MSVC AND CMAKE_JS_NODELIB_DEF AND CMAKE_JS_NODELIB_TARGET)
  # Generate node.lib
  execute_process(COMMAND ${CMAKE_AR} /def:${CMAKE_JS_NODELIB_DEF} /out:${CMAKE_JS_NODELIB_TARGET} ${CMAKE_STATIC_LINKER_FLAGS})
endif()