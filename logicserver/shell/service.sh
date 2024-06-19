#!/bin/bash

function start_func(){
    nowPath=$(dirname "$0")
    cd $nowPath
    parentPath=$(dirname $(pwd))
    # ps -o command -C skynet | grep "./skynet/skynet ./config/login.conf" &> /dev/null
    ps -o command -C skynet | grep "./skynet/skynet ./config/logic.conf" &> /dev/null
    [ $? -eq 0 ] && echo "进程$1已经存在,禁止重复启动" && return
    # 后台运行
    # nohup $parentPath/skynet/skynet $parentPath/config/login.conf &> /dev/null &
    nohup $parentPath/skynet/skynet $parentPath/config/logic.conf &>$parentPath/skynet.log 2>&1 &
    echo $parentPath, "服务器启动成功！"
}

function stop_func(){
    echo ""
}

function kill_func(){
    ps aux | grep "skynet"
    echo ""
}

case $1 in
    start)
        start_func
        echo "start shell";;
    stop)
        stop_func
        echo "stop shell";;
    kill)
        kill_func
        echo "kill shell";;
esac