local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"

skynet.start(function()
    skynet.error("logic server start...")
    -- 启动一个console后台
    skynet.newservice("debug_console", "127.0.0.1 8092")
    -- 启动一个协议服务，让客户端和服务器沟通
    -- skynet.uniqueservice("proto")
    -- 启动log服务
    -- skynet.name("log", skynet.uniqueservice("log"))
    -- 分发时机到所有游戏服务
    skynet.name("flow", skynet.uniqueservice("flow"))
    -- 启动的所有服务
    -- for i = 1, 10 do
    --     skynet.name(servername, skynet.uniqueservice("xxx"))
    -- end
    -- 分发时机
    skynet.call("flow", "lua", 1, "start")
    local loginserver = cluster.proxy("loginServer", ".logind")
    local gate = skynet.newservice("gated", loginserver)
    local servername = "logicServer"
    skynet.call(gate, "lua", "open", {host = "127.0.0.1", port = 8101, maxclient = 10, servername = servername})
    cluster.open(servername)
    -- 启动一个调试服务q
    
    -- local ver = skynetx.call("hacker", "version")
    -- 启动一个监测服务器状态的服务
    -- skynetx.newservice("statd", 127.0.0.1:8081)
    -- 启动一个接受后台协议的服务
    -- skynetx.newservice("support", machine.get("support_console_port"))

    skynet.error("logic server start success")
end)
