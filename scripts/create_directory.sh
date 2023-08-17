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

create_directory "./bootstrap/cache"
create_directory "./storage/app"
create_directory "./bootstrap/framework"