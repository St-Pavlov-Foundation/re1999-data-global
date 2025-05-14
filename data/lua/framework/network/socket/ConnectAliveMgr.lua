module("framework.network.socket.ConnectAliveMgr", package.seeall)

local var_0_0 = class("ConnectAliveMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._isConnected = false

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.init(arg_2_0)
	arg_2_0._connectLoginContext = {}
	arg_2_0._loginFlow = FlowSequence.New()
	arg_2_0._loginFlow.flowName = "loginFlow"

	arg_2_0._loginFlow:addWork(WorkConnectSocket.New(true))
	arg_2_0._loginFlow:addWork(WorkSystemLogin.New({
		connectWay = 0
	}))
	arg_2_0._loginFlow:registerDoneListener(arg_2_0._onLoginDone, arg_2_0)

	arg_2_0._keepAliveFlow = FlowSequence.New()
	arg_2_0._keepAliveFlow.flowName = "keepAliveFlow"

	arg_2_0._keepAliveFlow:addWork(WorkAliveConnectCheck.New())
	arg_2_0._keepAliveFlow:addWork(WorkWaitSeconds.New(1))
	arg_2_0._keepAliveFlow:addWork(WorkSocketDispose.New())
	arg_2_0._keepAliveFlow:addWork(WorkConnectSocket.New())
	arg_2_0._keepAliveFlow:addWork(WorkSystemLogin.New({
		connectWay = 1
	}))
	arg_2_0._keepAliveFlow:addWork(WorkGetLostCmdRespRequest.New())
	arg_2_0._keepAliveFlow:addWork(WorkResendPackets.New())
	arg_2_0._keepAliveFlow:registerDoneListener(arg_2_0._onLostConnect, arg_2_0)

	arg_2_0._reconectFlow = FlowSequence.New()
	arg_2_0._reconectFlow.flowName = "reconectFlow"

	arg_2_0._reconectFlow:addWork(WorkConnectSocket.New())
	arg_2_0._reconectFlow:addWork(WorkSystemLogin.New({
		connectWay = 1
	}))
	arg_2_0._reconectFlow:addWork(WorkGetLostCmdRespRequest.New())
	arg_2_0._reconectFlow:addWork(WorkResendPackets.New())
	arg_2_0._reconectFlow:registerDoneListener(arg_2_0._onReconnectDone, arg_2_0)

	arg_2_0._logoutFlow = FlowSequence.New()
	arg_2_0._logoutFlow.flowName = "logoutFlow"

	arg_2_0._logoutFlow:addWork(WorkSystemLogout.New())
	arg_2_0._logoutFlow:registerDoneListener(arg_2_0._onLogoutDone, arg_2_0)

	arg_2_0._preSender = AliveCheckPreSender.New()
	arg_2_0._preReceiver = AliveCheckPreReceiver.New(arg_2_0._preSender)

	LuaSocketMgr.instance:registerPreSender(arg_2_0._preSender)
	LuaSocketMgr.instance:registerPreReceiver(arg_2_0._preReceiver)
	var_0_0.instance:registerCallback(ConnectEvent.OnMsgTimeout, arg_2_0._onMsgTimeout, arg_2_0)
end

function var_0_0.dispose(arg_3_0)
	arg_3_0._loginFlow:stop()
	arg_3_0._keepAliveFlow:stop()
	arg_3_0._reconectFlow:stop()
	arg_3_0._logoutFlow:stop()

	arg_3_0._isConnected = false

	LuaSocketMgr.instance:unregisterPreSender(arg_3_0._preSender)
	LuaSocketMgr.instance:unregisterPreReceiver(arg_3_0._preReceiver)
	var_0_0.instance:unregisterCallback(ConnectEvent.OnMsgTimeout, arg_3_0._onMsgTimeout, arg_3_0)
end

function var_0_0.login(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._connectLoginContext.dontReconnect = nil
	arg_4_0._connectLoginContext.msg = nil
	arg_4_0._connectLoginContext.ip = arg_4_1
	arg_4_0._connectLoginContext.port = arg_4_2
	arg_4_0._connectLoginContext.account = arg_4_3
	arg_4_0._connectLoginContext.password = arg_4_4
	arg_4_0._loginCallback = arg_4_5
	arg_4_0._loginCallbackObj = arg_4_6

	arg_4_0:clearUnresponsiveMsgList()
	arg_4_0._loginFlow:start(arg_4_0._connectLoginContext)
end

function var_0_0.logout(arg_5_0)
	if arg_5_0._loginFlow.status == WorkStatus.Running then
		arg_5_0._loginFlow:stop()
		logError("都没登录成功，怎么logout的")
	end

	if arg_5_0._logoutFlow.status == WorkStatus.Running then
		arg_5_0._logoutFlow:stop()
		logError("重复调用logout了")
	end

	if arg_5_0._keepAliveFlow.status == WorkStatus.Running then
		arg_5_0._keepAliveFlow:stop()
		logNormal("活动连接过程中调用logout")
	end

	if arg_5_0._reconectFlow.status == WorkStatus.Running then
		arg_5_0._reconectFlow:stop()
		logNormal("重连过程中调用logout")
	end

	arg_5_0._isConnected = false

	arg_5_0._logoutFlow:start({})
	arg_5_0:clearUnresponsiveMsgList()
	arg_5_0:clearCurrDownTag()
end

function var_0_0.reconnect(arg_6_0)
	arg_6_0._connectLoginContext.dontReconnect = nil
	arg_6_0._connectLoginContext.msg = nil

	arg_6_0._reconectFlow:start(arg_6_0._connectLoginContext)
end

function var_0_0.stopReconnect(arg_7_0)
	if arg_7_0._reconectFlow.status == WorkStatus.Running then
		arg_7_0._reconectFlow:stop()
	end
end

function var_0_0.isConnected(arg_8_0)
	return arg_8_0._isConnected
end

function var_0_0.getFirstUnresponsiveMsg(arg_9_0)
	return arg_9_0._preSender:getFirstUnresponsiveMsg()
end

function var_0_0.getUnresponsiveMsgList(arg_10_0)
	return arg_10_0._preSender:getUnresponsiveMsgList()
end

function var_0_0.clearUnresponsiveMsgList(arg_11_0)
	arg_11_0._preSender:clear()
end

function var_0_0.addUnresponsiveMsg(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._preSender:preSendProto(arg_12_1, arg_12_2, arg_12_3)
end

function var_0_0.ignoreUnimportantCmds(arg_13_0)
	arg_13_0._preSender:ignoreUnimportantCmds()
end

function var_0_0.setNonResendCmds(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		WorkResendPackets.NonResendCmdDict[iter_14_1] = true
	end
end

function var_0_0.getCurrDownTag(arg_15_0)
	return arg_15_0._preReceiver:getCurrDownTag()
end

function var_0_0.clearCurrDownTag(arg_16_0)
	arg_16_0._preReceiver:clearCurrDownTag()
end

function var_0_0.lostMessage(arg_17_0)
	LuaSocketMgr.instance:endConnect()

	arg_17_0._connectLoginContext.dontReconnect = true

	arg_17_0._loginFlow:stop()
	arg_17_0._keepAliveFlow:stop()
	arg_17_0._reconectFlow:stop()
	arg_17_0._logoutFlow:stop()

	arg_17_0._isConnected = false

	var_0_0.instance:dispatchEvent(ConnectEvent.OnLostMessage)
end

function var_0_0._onLoginDone(arg_18_0, arg_18_1)
	if arg_18_1 then
		logNormal("<color=#00FF00>ConnectAliveMgr:_onLoginDone() success </color>")

		arg_18_0._connectLoginContext.dontReconnect = nil
		arg_18_0._connectLoginContext.msg = nil
		arg_18_0._isConnected = true

		arg_18_0._keepAliveFlow:start(arg_18_0._connectLoginContext)
	else
		arg_18_0._isConnected = false

		logNormal("<color=red>ConnectAliveMgr:_onLoginDone() fail </color>")
		LuaSocketMgr.instance:endConnect()
	end

	if arg_18_0._loginCallback then
		local var_18_0 = {}

		if arg_18_0._connectLoginContext.socketFail then
			arg_18_0._connectLoginContext.socketFail = nil
			var_18_0.socketFail = true
		end

		if arg_18_0._connectLoginContext.systemLoginFail then
			arg_18_0._connectLoginContext.systemLoginFail = nil
			var_18_0.systemLoginFail = true
			var_18_0.msg = arg_18_0._connectLoginContext.msg
			arg_18_0._connectLoginContext.msg = nil
		end

		if arg_18_0._loginCallbackObj then
			arg_18_0._loginCallback(arg_18_0._loginCallbackObj, arg_18_1, var_18_0)
		else
			arg_18_0._loginCallback(arg_18_1, var_18_0)
		end
	end

	arg_18_0._loginCallback = nil
	arg_18_0._loginCallbackObj = nil
end

function var_0_0._onLogoutDone(arg_19_0, arg_19_1)
	logNormal("<color=orange>主动登出完成</color>")
end

function var_0_0._onMsgTimeout(arg_20_0)
	arg_20_0._isConnected = false
end

function var_0_0._onLostConnect(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._keepAliveFlow.context.dontReconnect
	local var_21_1 = arg_21_0._keepAliveFlow.context.msg

	arg_21_0._connectLoginContext.dontReconnect = nil
	arg_21_0._connectLoginContext.msg = nil

	if arg_21_1 then
		logNormal("<color=orange>断线自动重连成功</color>")

		arg_21_0._isConnected = true

		arg_21_0._keepAliveFlow:start(arg_21_0._connectLoginContext)
	else
		arg_21_0._isConnected = false

		logNormal("<color=orange>断线了，需要用户操作重连</color>")
		LuaSocketMgr.instance:endConnect()
		var_0_0.instance:dispatchEvent(ConnectEvent.OnLostConnect, var_21_0, var_21_1)
	end
end

function var_0_0._onReconnectDone(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._reconectFlow.context.dontReconnect
	local var_22_1 = arg_22_0._reconectFlow.context.msg

	arg_22_0._connectLoginContext.dontReconnect = nil
	arg_22_0._connectLoginContext.msg = nil

	if arg_22_1 then
		logNormal("<color=#00FF00>用户主动重连成功</color>")

		arg_22_0._isConnected = true

		arg_22_0._keepAliveFlow:start(arg_22_0._connectLoginContext)
		var_0_0.instance:dispatchEvent(ConnectEvent.OnReconnectSucc)
	else
		arg_22_0._isConnected = false

		logNormal("<color=#00FF00>用户主动重连失败，需要用户再次操作重连</color>")
		LuaSocketMgr.instance:endConnect()
		var_0_0.instance:dispatchEvent(ConnectEvent.OnReconnectFail, var_22_0, var_22_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
