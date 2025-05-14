module("framework.network.socket.LuaSocketMgr", package.seeall)

local var_0_0 = class("LuaSocketMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._systemCmds = nil
	arg_1_0._moduleCmds = nil
	arg_1_0._preSenders = {}
	arg_1_0._preReceivers = {}
	arg_1_0._req2CmdDict = {}
	arg_1_0._res2CmdDict = {}
	arg_1_0._csSocketMgr = SLFramework.SocketMgr.Instance
	arg_1_0._ignoreSomeCmdLog = false
	arg_1_0._ignoreCmds = {}
	arg_1_0._headerSize4Send = 11
end

function var_0_0.setIgnoreSomeCmdLog(arg_2_0, arg_2_1)
	if not arg_2_1 then
		arg_2_0._ignoreSomeCmdLog = false

		return
	end

	arg_2_0._ignoreSomeCmdLog = true

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0._ignoreCmds[iter_2_1] = true
	end
end

function var_0_0._canLog(arg_3_0, arg_3_1)
	return not arg_3_0._ignoreSomeCmdLog or not arg_3_0._ignoreCmds[arg_3_1]
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._systemCmds = arg_4_1
	arg_4_0._moduleCmds = arg_4_2

	for iter_4_0, iter_4_1 in pairs(arg_4_0._moduleCmds) do
		if #iter_4_1 == 3 then
			arg_4_0._req2CmdDict[iter_4_1[2]] = iter_4_0
			arg_4_0._res2CmdDict[iter_4_1[3]] = iter_4_0
		elseif #iter_4_1 == 2 then
			arg_4_0._res2CmdDict[iter_4_1[2]] = iter_4_0
		end
	end

	arg_4_0._csSocketMgr:SetLuaHandler(arg_4_0._onReceiveMainMsg, arg_4_0, SocketId.Main)
end

function var_0_0.reInit(arg_5_0)
	arg_5_0._csSocketMgr:Dispose()
	arg_5_0._csSocketMgr:SetLuaHandler(arg_5_0._onReceiveMainMsg, arg_5_0, SocketId.Main)
end

function var_0_0.registerPreSender(arg_6_0, arg_6_1)
	table.insert(arg_6_0._preSenders, arg_6_1)
end

function var_0_0.unregisterPreSender(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._preSenders) do
		if iter_7_1 == arg_7_1 then
			table.remove(arg_7_0._preSenders, iter_7_0)

			break
		end
	end
end

function var_0_0.registerPreReceiver(arg_8_0, arg_8_1)
	table.insert(arg_8_0._preReceivers, arg_8_1)
end

function var_0_0.unregisterPreReceiver(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._preReceivers) do
		if iter_9_1 == arg_9_1 then
			table.remove(arg_9_0._preReceivers, iter_9_0)

			break
		end
	end
end

function var_0_0.setConnectBeginCallback(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._csSocketMgr:SetConnectBeginCallback(arg_10_1, arg_10_2, arg_10_3 or SocketId.Main)
end

function var_0_0.setConnectEndCallback(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._csSocketMgr:setConnectEndCallback(arg_11_1, arg_11_2, arg_11_3 or SocketId.Main)
end

function var_0_0.setSeqId(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._csSocketMgr:SetSeqId(arg_12_1, arg_12_2 or SocketId.Main)
end

function var_0_0.beginConnect(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	return arg_13_0._csSocketMgr:BeginConnect(arg_13_1, arg_13_2, arg_13_3 or SocketId.Main)
end

function var_0_0.endConnect(arg_14_0, arg_14_1)
	arg_14_0._csSocketMgr:EndConnect(arg_14_1 or SocketId.Main)
end

function var_0_0.isConnected(arg_15_0, arg_15_1)
	return arg_15_0._csSocketMgr:IsConnected(arg_15_1 or SocketId.Main)
end

function var_0_0.sendSysMsg(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._preSenders) do
		var_16_0 = iter_16_1.preSendSysMsg and iter_16_1:preSendSysMsg(arg_16_1, arg_16_2, arg_16_3 or SocketId.Main) or var_16_0
	end

	if not var_16_0 then
		arg_16_0:reallySendSysMsg(arg_16_1, arg_16_2, arg_16_3 or SocketId.Main)
	end
end

function var_0_0.getSysMsgSendBuffLen(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._systemCmds.GetSendMsg(arg_17_1, arg_17_2)

	return string.len(var_17_0) + arg_17_0._headerSize4Send
end

function var_0_0.reallySendSysMsg(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0._systemCmds.GetSendMsg(arg_18_1, arg_18_2)

	arg_18_0._csSocketMgr:SendMsg(arg_18_1, var_18_0, arg_18_3 or SocketId.Main)

	local var_18_1 = arg_18_0._systemCmds.GetRequestName(arg_18_1)

	if canLogNormal and isDebugBuild and arg_18_0:_canLog(var_18_1) then
		logNormal(string.format("==> Send Sys Msg, cmd:%d %s size:%d\n%s", arg_18_1, var_18_1, string.len(var_18_0), cjson.encode(arg_18_2)))
	end
end

function var_0_0.sendMsg(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1.__cname
	local var_19_1 = arg_19_0._req2CmdDict[var_19_0]

	if var_19_1 then
		local var_19_2

		for iter_19_0, iter_19_1 in ipairs(arg_19_0._preSenders) do
			if iter_19_1.blockSendProto then
				var_19_2 = iter_19_1:blockSendProto(var_19_1, arg_19_1, arg_19_2 or SocketId.Main)

				if var_19_2 then
					break
				end
			end
		end

		if not var_19_2 then
			for iter_19_2, iter_19_3 in ipairs(arg_19_0._preSenders) do
				if iter_19_3.preSendProto then
					iter_19_3:preSendProto(var_19_1, arg_19_1, arg_19_2 or SocketId.Main)
				end
			end

			arg_19_0:reallySendMsg(var_19_1, arg_19_1, arg_19_2 or SocketId.Main)
		else
			logWarn("LuaSocketMgr block " .. var_19_0)
		end
	else
		logError("cmd not exist: " .. var_19_0)
	end
end

function var_0_0.reallySendMsg(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2:SerializeToString()

	arg_20_0._csSocketMgr:SendMsg(arg_20_1, var_20_0, arg_20_3 or SocketId.Main)

	local var_20_1 = arg_20_2.__cname

	if canLogNormal and isDebugBuild and arg_20_0:_canLog(var_20_1) then
		logNormal(string.format("==> Send Msg, cmd:%d %s size:%d\n%s", arg_20_1, var_20_1, string.len(var_20_0), tostring(arg_20_2)))
	end
end

function var_0_0._onReceiveMainMsg(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = arg_21_0._systemCmds[arg_21_2]

	if var_21_0 then
		local var_21_1 = arg_21_0._systemCmds.GetReceiveMsg(arg_21_2, arg_21_3)
		local var_21_2 = arg_21_0._systemCmds.GetResponseName(arg_21_2)

		if canLogNormal and isDebugBuild and arg_21_0:_canLog(var_21_2) then
			logNormal(string.format("<== Recv Sys Msg, cmd:%d %s size:%d resultCode:%d downTag:%d\n%s", arg_21_2, var_21_2, string.len(arg_21_3), arg_21_1, arg_21_4, cjson.encode(var_21_1)))
		end

		local var_21_3

		for iter_21_0, iter_21_1 in ipairs(arg_21_0._preReceivers) do
			var_21_3 = iter_21_1.preReceiveSysMsg and iter_21_1:preReceiveSysMsg(arg_21_1, arg_21_2, var_21_2, var_21_1, arg_21_4, arg_21_5) or var_21_3
		end

		if not var_21_3 then
			arg_21_0:_rpcReceiveMsg(var_21_0[1], true, arg_21_1, arg_21_2, var_21_2, var_21_1, arg_21_4, arg_21_5)
		end
	else
		local var_21_4 = arg_21_0._moduleCmds[arg_21_2]

		if not var_21_4 then
			logError("cmd not exist: " .. arg_21_2)

			return
		end

		local var_21_5 = #var_21_4 == 3 and var_21_4[3] or var_21_4[2]
		local var_21_6 = var_21_4[1] .. "Module_pb"
		local var_21_7 = getGlobal(var_21_6) or addGlobalModule("modules.proto." .. var_21_6, var_21_6)

		if not var_21_7 then
			logError(string.format("pb not exist: %s res = %s", var_21_6, var_21_5))

			return
		end

		local var_21_8 = var_21_7[var_21_5]()

		var_21_8:ParseFromString(arg_21_3)

		if canLogNormal and isDebugBuild and arg_21_0:_canLog(var_21_5) then
			local var_21_9 = arg_21_1 == 0 and "" or "<color=#FFA500>"
			local var_21_10 = arg_21_1 == 0 and "" or "</color>"

			logNormal(string.format("%s<== Recv Msg, cmd:%d %s size:%d resultCode:%d downTag:%d%s\n%s", var_21_9, arg_21_2, var_21_5, string.len(arg_21_3), arg_21_1, arg_21_4, var_21_10, tostring(var_21_8)))

			if string.len(arg_21_3) > 1000 then
				local var_21_11 = tostring(var_21_8)
				local var_21_12 = string.split(var_21_11, "\n")
				local var_21_13 = math.ceil(#var_21_12 / 500)

				for iter_21_2 = 1, var_21_13 do
					local var_21_14 = (iter_21_2 - 1) * 500 + 1
					local var_21_15 = math.min(iter_21_2 * 500, #var_21_12)

					logNormal(table.concat(var_21_12, "\n", var_21_14, var_21_15))
				end
			end
		end

		local var_21_16

		for iter_21_3, iter_21_4 in ipairs(arg_21_0._preReceivers) do
			var_21_16 = iter_21_4.preReceiveMsg and iter_21_4:preReceiveMsg(arg_21_1, arg_21_2, var_21_5, var_21_8, arg_21_4, arg_21_5) or var_21_16
		end

		if not var_21_16 then
			arg_21_0:_rpcReceiveMsg(var_21_4[1], false, arg_21_1, arg_21_2, var_21_5, var_21_8, arg_21_4, arg_21_5)
		end
	end
end

function var_0_0._rpcReceiveMsg(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)
	if arg_22_2 then
		SystemLoginRpc.instance:onReceiveMsg(arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)

		return
	end

	local var_22_0 = getGlobal(arg_22_1 .. "Rpc")

	if var_22_0 and var_22_0["onReceive" .. arg_22_5] then
		var_22_0.instance:onReceiveMsg(arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)

		return
	else
		local var_22_1 = ModuleMgr.instance:getSetting(arg_22_1)

		if var_22_1 and var_22_1.rpc then
			for iter_22_0, iter_22_1 in ipairs(var_22_1.rpc) do
				local var_22_2 = getGlobal(iter_22_1)

				if var_22_2 and var_22_2["onReceive" .. arg_22_5] then
					var_22_2.instance:onReceiveMsg(arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7, arg_22_8)

					return
				end
			end
		end
	end

	logError(string.format("cmd_%d onReceive%s = nil, module:%s", arg_22_4, arg_22_5, arg_22_1))
end

function var_0_0.getCmdByPbStructName(arg_23_0, arg_23_1)
	return arg_23_0._req2CmdDict[arg_23_1] or arg_23_0._res2CmdDict[arg_23_1]
end

function var_0_0.getCmdSettingDict(arg_24_0)
	return arg_24_0._moduleCmds
end

function var_0_0.getCmdSetting(arg_25_0, arg_25_1)
	return arg_25_0._moduleCmds[arg_25_1]
end

function var_0_0.getSysCmdSetting(arg_26_0, arg_26_1)
	return arg_26_0._systemCmds[arg_26_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
