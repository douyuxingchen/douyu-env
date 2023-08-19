#!/bin/bash

create_directory() {
    local directory="$1"

    if [ ! -d "$directory" ]; then
        mkdir -p "$directory"
        echo "目录已创建: $directory"
    else
        echo "目录已存在: $directory"
    fi
}

create_directory "./storage/app"
create_directory "./storage/logs"
create_directory "./storage/framework/cache"
create_directory "./storage/framework/sessions"
create_directory "./storage/framework/views"
create_directory "./storage/framework/testing"