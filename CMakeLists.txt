cmake_minimum_required(VERSION 3.0.2)
project(load_venv)

find_package(catkin REQUIRED)

catkin_package()

catkin_add_env_hooks(load_venv SHELLS sh DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/env-hooks)
