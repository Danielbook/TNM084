cmake_minimum_required(VERSION 3.6)
set(APP_NAME "lab1")
project(${APP_NAME})

set(GLFW_SOURCE_DIR "ext/glfw")

# Build only the GLFW lib
set(BUILD_SHARED_LIBS OFF CACHE BOOL "")
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "")
set(GLFW_BUILD_TESTS OFF CACHE BOOL "")
set(GLFW_BUILD_DOCS OFF CACHE BOOL "")
set(GLFW_INSTALL OFF CACHE BOOL "")

add_subdirectory(${GLFW_SOURCE_DIR})
include_directories(${GLFW_SOURCE_DIR}/include ${GLFW_SOURCE_DIR}/deps)

find_package(OpenGL REQUIRED)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wpedantic -g")

set(PROJECT_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include)
set(PROJECT_EXEC_DIR ${CMAKE_SOURCE_DIR}/src)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

include_directories(${PROJECT_INCLUDE_DIR} ${OPENGL_INCLUDE_DIR})

#message(WARNING "All exec files: ${PROJECT_EXEC_DIR}")
#message(WARNING "All include dirs: ${PROJECT_INCLUDE_DIR}")
#message(WARNING "Find OpenGL variables: ${OPENGL_INCLUDE_DIR}, ${OPENGL_gl_LIBRARY}")

file(GLOB PROJECT_FILES ${PROJECT_EXEC_DIR}/*.c)
set(SOURCE_FILES ${PROJECT_FILES})
add_executable(${APP_NAME} ${SOURCE_FILES})

target_link_libraries(${APP_NAME} glfw ${GLFW_LIBRARIES} ${OPENGL_gl_LIBRARY} m)

