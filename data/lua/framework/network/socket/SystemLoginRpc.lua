module("framework.network.socket.SystemLoginRpc", package.seeall)

local var_0_0 = class("SystemLoginRpc", BaseRpc)

function var_0_0.sendLoginRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	local var_1_0 = {
		account = arg_1_1,
		password = arg_1_2,
		connectWay = arg_1_3
	}

	logNormal("请求系统登录: " .. cjson.encode(var_1_0))

	return arg_1_0:sendSysMsg(1, var_1_0, arg_1_4, arg_1_5)
end

function var_0_0.onReceiveLoginResponse(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		logNormal("登录成功！ login succ, userId = " .. arg_2_2.userId)
	else
		logNormal("登录失败！ login fail: " .. arg_2_2.reason)
	end

	LuaSocketMgr.instance:setSeqId(0)
end

function var_0_0.sendGetLostCmdRespRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {
		downTag = arg_3_1 or 0
	}

	return arg_3_0:sendSysMsg(3, var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveGetLostCmdRespResponse(arg_4_0, arg_4_1, arg_4_2)
	logNormal("请求补包结束，是否真的有补发协议：canGet = " .. (arg_4_2.canGet and "true" or "false"))
end

function var_0_0.onReceiveForceLogoutResponse(arg_5_0, arg_5_1, arg_5_2)
	logNormal(string.format("<color=red>被系统强踢下线 reason = %s resultCode = %d</color>", arg_5_2.reason or "nil", arg_5_1))
	ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnServerKickedOut, arg_5_2.reason, arg_5_1)
end

function var_0_0.onReceiveGetLostCmdRespResponseStartTag(arg_6_0, arg_6_1, arg_6_2)
	logNormal("服务端开始补发重连期间错过的业务协议！！！")
end

var_0_0.instance = var_0_0.New()

return var_0_0
