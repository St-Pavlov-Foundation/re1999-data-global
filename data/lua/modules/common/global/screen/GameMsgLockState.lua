module("modules.common.global.screen.GameMsgLockState", package.seeall)

local var_0_0 = class("GameMsgLockState")

var_0_0.IgnoreCmds = {
	[24032] = true,
	[-31567] = true
}
var_0_0.IgnoreExceptionCmd = {
	25708
}
var_0_0.IgnoreExceptionStatus = {
	-274,
	-275,
	-276,
	-277,
	-278,
	-123,
	-124,
	-15,
	-13,
	-26,
	-310,
	-311,
	-312,
	-314,
	-321,
	-402,
	-403
}

function var_0_0.ctor(arg_1_0)
	arg_1_0._sendCmdList = {}
	arg_1_0._sendProtoList = {}
	arg_1_0._ignoreExceptionCmd = {}
	arg_1_0._ignoreExceptionStatus = {}
	arg_1_0._blockCmdDict = {}
	arg_1_0._blockCount = 0

	arg_1_0:addConstEvents()
end

function var_0_0.addConstEvents(arg_2_0)
	LuaSocketMgr.instance:registerPreSender(arg_2_0)
	LuaSocketMgr.instance:registerPreReceiver(arg_2_0)
	arg_2_0:setIgnoreException(var_0_0.IgnoreExceptionCmd, var_0_0.IgnoreExceptionStatus)
	LoginController.instance:registerCallback(LoginEvent.OnLogout, arg_2_0._endBlock, arg_2_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, arg_2_0._endBlock, arg_2_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnMsgTimeout, arg_2_0._endBlock, arg_2_0)
end

function var_0_0.preSendProto(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if var_0_0.IgnoreCmds[arg_3_1] then
		return
	end

	if arg_3_0._blockCount == 0 then
		UIBlockMgr.instance:startBlock(UIBlockKey.MsgLock)
	end

	arg_3_0._blockCmdDict[arg_3_1] = arg_3_0._blockCmdDict[arg_3_1] and arg_3_0._blockCmdDict[arg_3_1] + 1 or 1
	arg_3_0._blockCount = arg_3_0._blockCount + 1

	TaskDispatcher.cancelTask(arg_3_0._onDelayCancelLock, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._onDelayCancelLock, arg_3_0, 30)
	table.insert(arg_3_0._sendCmdList, arg_3_1)
	table.insert(arg_3_0._sendProtoList, arg_3_2)
end

function var_0_0.preReceiveMsg(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if var_0_0.IgnoreCmds[arg_4_2] then
		return
	end

	local var_4_0

	while #arg_4_0._sendCmdList > 0 do
		local var_4_1 = table.remove(arg_4_0._sendCmdList, #arg_4_0._sendCmdList)
		local var_4_2 = table.remove(arg_4_0._sendProtoList, #arg_4_0._sendProtoList)

		if var_4_1 == arg_4_2 then
			var_4_0 = var_4_2

			break
		end
	end

	if arg_4_1 ~= 0 and arg_4_0:_canLogException(arg_4_2, arg_4_1) then
		local var_4_3 = lua_toast.configDict[arg_4_1]
		local var_4_4 = var_4_3 and var_4_3.tips or ""
		local var_4_5 = var_4_0 and tostring(var_4_0) or ""

		logError(string.format("<== Recv Msg, cmd:%d %s resultCode:%d desc:%s param:%s", arg_4_2, arg_4_3, arg_4_1, var_4_4, var_4_5))
	end

	local var_4_6 = arg_4_0._blockCmdDict[arg_4_2]

	if var_4_6 and var_4_6 > 0 then
		if var_4_6 == 1 then
			arg_4_0._blockCmdDict[arg_4_2] = nil
		else
			arg_4_0._blockCmdDict[arg_4_2] = var_4_6 - 1
		end

		arg_4_0._blockCount = arg_4_0._blockCount - 1

		if arg_4_0._blockCount == 0 then
			UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)
			TaskDispatcher.cancelTask(arg_4_0._onDelayCancelLock, arg_4_0)
		end
	end
end

function var_0_0._onDelayCancelLock(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._blockCmdDict) do
		table.insert(var_5_0, module_cmd[iter_5_0][2])
	end

	arg_5_0:_endBlock()

	if isDebugBuild then
		logError("msg lock: " .. table.concat(var_5_0, " "))
	end
end

function var_0_0._endBlock(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onDelayCancelLock, arg_6_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)

	arg_6_0._sendCmdList = {}
	arg_6_0._sendProtoList = {}
	arg_6_0._blockCmdDict = {}
	arg_6_0._blockCount = 0
end

function var_0_0.setIgnoreException(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			arg_7_0._ignoreExceptionCmd[iter_7_1] = true
		end
	end

	if arg_7_2 then
		for iter_7_2, iter_7_3 in ipairs(arg_7_2) do
			arg_7_0._ignoreExceptionStatus[iter_7_3] = true
		end
	end
end

function var_0_0._canLogException(arg_8_0, arg_8_1, arg_8_2)
	return not arg_8_0._ignoreExceptionCmd[arg_8_1] and not arg_8_0._ignoreExceptionStatus[arg_8_2]
end

return var_0_0
