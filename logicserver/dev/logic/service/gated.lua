-- 构建一个登录服和逻辑服的网关服务
local msgserver = require "snax.msgserver"
local skynet = require "skynet"

local loginServer = tonumber(...)

local server = {}

function server.login_handler()
end
function server.logout_handler()
end
function server.kick_handler()
end
function server.stop_handler()
end
function server.rebate_handler()
end
function server.reloadconfig_handler()
end
function server.clearmachine_handler()
end
function server.request_handler()
end
function server.register_handler()
end
msgserver.start(server)