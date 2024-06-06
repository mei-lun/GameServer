--构建一个和后台联系的模块，直接联系mysql

local skynet = require "skynet"

local commands = {}

function commands:loadUser()
    skynet.error("cache loadUser...")
    return "cache loadUser success!"
end

local function init()
    -- 初始化数据库连接
end

local function receive(session, address, cmd, ...)	
    skynet.error("**********cmd: " .. cmd)
    -- 定义数据处理函数
    local func = commands[cmd]
    if func then
        skynet.retpack(func(...))
    end
end

skynet.start(function()
    init()
    skynet.dispatch("lua", receive)
end)