local skynet = require "skynet"
local cluster = require "skynet.cluster"
require "skynet.manager"

skynet.start(function()
    skynet.error("login server start...")
    -- 启动一个console后台
    skynet.newservice("debug_console", "127.0.0.1 8082")
    -- 启动一个cache服务，构建和后台的联系
    skynet.name("cache", skynet.uniqueservice("cache"))
    -- 启动登录服服务
    skynet.name(".logind", skynet.uniqueservice("login"))
    skynet.call(".logind", "lua", "start")
    cluster.open("loginServer")

    skynet.error("login server start success")
end)
