module("framework.network.socket.work.WorkConnectSocket", package.seeall)

local var_0_0 = class("WorkConnectSocket", BaseWork)
local var_0_1 = "ConnectSocket"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._firstLogin = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0._ip = SLFramework.UnityHelper.ParseDomainToIp(arg_2_1.ip)
	arg_2_0._port = arg_2_1.port

	if arg_2_0._firstLogin then
		arg_2_0._startTime = os.time()

		SLFramework.TimeWatch.Instance:Start()

		local var_2_0 = {
			account = arg_2_1.account,
			password = arg_2_1.password
		}

		var_2_0.connectWay = 0
		arg_2_0._dataLength = LuaSocketMgr.instance:getSysMsgSendBuffLen(1, var_2_0)
	end

	UIBlockMgr.instance:startBlock(var_0_1)
	LuaSocketMgr.instance:setConnectBeginCallback(arg_2_0._onConnectBegin, arg_2_0)

	if LuaSocketMgr.instance:beginConnect(arg_2_0._ip, arg_2_0._port) then
		TaskDispatcher.runDelay(arg_2_0._onConnectTimeout, arg_2_0, NetworkConst.SocketConnectTimeout)
	else
		logWarn("<color=#FF0000>connect fail: isConnecting, or IpEndPoint = null</color>")

		arg_2_0.context.socketFail = true

		arg_2_0:onDone(false)
	end
end

function var_0_0.onResume(arg_3_0)
	LuaSocketMgr.instance:setConnectBeginCallback(arg_3_0._onConnectBegin, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._onConnectTimeout, arg_3_0, NetworkConst.SocketConnectTimeout)
end

function var_0_0.clearWork(arg_4_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	LuaSocketMgr.instance:setConnectBeginCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_4_0._onConnectTimeout, arg_4_0)
end

function var_0_0._onConnectBegin(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._firstLogin then
		local var_5_0 = arg_5_2 and SDKDataTrackMgr.RequestResult.success or SDKDataTrackMgr.RequestResult.fail
		local var_5_1 = SLFramework.TimeWatch.Instance:Watch()
		local var_5_2 = var_5_1 - var_5_1 % 0.001

		SDKDataTrackMgr.instance:trackSocketConnectEvent(var_5_0, arg_5_0._startTime, var_5_2, arg_5_0._dataLength, arg_5_0._ip .. ":" .. arg_5_0._port)
	end

	if arg_5_2 then
		arg_5_0.context.socketFail = nil

		arg_5_0:onDone(true)
	else
		arg_5_0.context.socketFail = true

		arg_5_0:onDone(false)
	end
end

function var_0_0._onConnectTimeout(arg_6_0)
	if arg_6_0._firstLogin then
		local var_6_0 = SLFramework.TimeWatch.Instance:Watch()
		local var_6_1 = var_6_0 - var_6_0 % 0.001

		SDKDataTrackMgr.instance:trackSocketConnectEvent(SDKDataTrackMgr.RequestResult.fail, arg_6_0._startTime, var_6_1, arg_6_0._dataLength, arg_6_0._ip .. ":" .. arg_6_0._port)
	end

	arg_6_0.context.socketFail = true

	arg_6_0:onDone(false)
end

return var_0_0
