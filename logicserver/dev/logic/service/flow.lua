-- 通过这个服务启动所有的游戏里的服务
local skynet = require "skynet"
local PROTO_TYEP = "lua"
local PROTO_MODE = {}
-- 定义这个是因为，消息发到这个服务的时候，我们不知道什么哪个消息需要回送哪个不需要
PROTO_MODE.call = 1
PROTO_MODE.send = 2

local CMD = {}
function CMD:start()
    skynet.error("call flow start CMD")
    return true
end

skynet.start(function()
    skynet.error("flow begin...")
    skynet.dispatch(PROTO_TYEP, function(session, address, mode, command, ...)
        skynet.error("in flow call cmd: " .. tostring(command))
        if mode == PROTO_MODE.call then
            skynet.retpack(CMD[command](self, ...))
        elseif  mode == PROTO_MODE.send then
            CMD[command](self, ...)
        else
            skynet.error("error command")
        end
    end)
    skynet.error("flow end...")
end)