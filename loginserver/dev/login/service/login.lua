local login = require "snax.loginserver"
local skynet = require "skynet"
local crypt = require "skynet.crypt"

--游戏服id可以自己组装,集群的服务名字，字符串类型
local gameserver = "logicServer100"

local server = {
	host = "127.0.0.1",
	port = 8001,
	multilogin = false,	-- disallow multilogin
	name = "login_master",
    instance = 1,
}
-- 实现登录服接口
function server.auth_handler(token)
	-- the token is base64(user)@base64(server):base64(password)
	local user, server, password = token:match("([^@]+)@([^:]+):(.+)")
	user = crypt.base64decode(user)
	server = crypt.base64decode(server)
	password = crypt.base64decode(password)
	assert(password == "password", "Invalid password")
	return server, user
end

function server.login_handler(server, uid, secret)
	print(string.format("%s@%s is login, secret is %s", uid, server, crypt.hexencode(secret)))

	-- local subid = tostring(skynet.call(gameserver, "lua", "login", uid, secret) or 123)
	local subid = "123"
	-- user_online[uid] = { address = gameserver, subid = subid , server = server}
	return subid
end
-- 自定义函数接口
local CMD = {}
function server.command_handler(command, ...)
	local f = assert(CMD[command])
	return f(...)
end

function CMD.start()
    local user = skynet.call("cache", "lua", "loadUser")
    skynet.error(user)
end

function CMD.register_gate(server, address)
	server_list[server] = address
end

return login(server)