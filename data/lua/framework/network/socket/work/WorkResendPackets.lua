module("framework.network.socket.work.WorkResendPackets", package.seeall)

local var_0_0 = class("WorkResendPackets", BaseWork)

var_0_0.NonResendCmdDict = {}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = ConnectAliveMgr.instance:getUnresponsiveMsgList()

	ConnectAliveMgr.instance:clearUnresponsiveMsgList()

	local var_1_1 = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_2 = var_1_0[iter_1_0]

		if not var_0_0.NonResendCmdDict[var_1_2.cmd] then
			var_1_2.time = Time.realtimeSinceStartup

			LuaSocketMgr.instance:sendMsg(var_1_2.msg, var_1_2.socketId)
			table.insert(var_1_1, var_1_2.msg.__cname)
		end
	end

	if #var_1_1 > 0 then
		logNormal("前端补包协议：" .. table.concat(var_1_1, ","))
	end

	arg_1_0:onDone(true)
end

return var_0_0
