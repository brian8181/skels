
# @name     new3
# @file:    CMakeLists.txt
# @date:    Wed, 31 Dec 2025 02:45:31 +0000
# @version: 0.0.1

cmake_minimum_required(VERSION 3.28.3)
project(scanner)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

#set(BUILD_SHARED_LIBS YES)

if(CMAKE_SYSTEM_NAME STREQUAL "CYGWIN")
    message(STATUS "Building under Cygwin, defining CYGWIN macro")
    add_definitions(-DCYGWIN)
endif()

add_executable(new3
    src/new3.cpp
    src/main.cpp
)


add_library(new3_a STATIC
    src/new3.cpp

)

#[=[
    # Add Library
    add_library(targetName [STATIC | SHARED | MODULE]
    [EXCLUDE_FROM_ALL]
    source1 [source2 ...]
)
]=]`

#[=[
install(TARGETS MyApp AlgoRuntime AlgoSDK
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
]=]
