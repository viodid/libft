cmake_minimum_required(VERSION 3.0)

project(GNL)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Werror")

include_directories(.)

add_executable(GNL test.c get_next_line.c get_next_line.h get_next_line_utils.c)
