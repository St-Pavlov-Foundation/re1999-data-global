module("framework.mvc.BaseRpc", package.seeall)

local var_0_0 = class("BaseRpc")

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitInternal(arg_3_0)
	arg_3_0._callbackId = 0
	arg_3_0._cmdCallbackTab = {}

	arg_3_0:onInit()
end

function var_0_0.reInitInternal(arg_4_0)
	arg_4_0._callbackId = 0
	arg_4_0._cmdCallbackTab = {}

	arg_4_0:reInit()
end

function var_0_0.sendSysMsg(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if LuaSocketMgr.instance:isConnected(arg_5_5) then
		LuaSocketMgr.instance:sendSysMsg(arg_5_1, arg_5_2, arg_5_5)

		return arg_5_0:addCallback(arg_5_1, arg_5_3, arg_5_4)
	else
		logWarn("send system cmd_" .. arg_5_1 .. " fail, reason: lost connect")
	end
end

function var_0_0.sendMsg(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = LuaSocketMgr.instance:getCmdByPbStructName(arg_6_1.__cname)

	if LuaSocketMgr.instance:isConnected(arg_6_4) and ConnectAliveMgr.instance:isConnected() then
		LuaSocketMgr.instance:sendMsg(arg_6_1, arg_6_4)

		return arg_6_0:addCallback(var_6_0, arg_6_2, arg_6_3)
	else
		logWarn("send protobuf cmd_" .. var_6_0 .. " fail, reason: lost connect")
		ConnectAliveMgr.instance:addUnresponsiveMsg(var_6_0, arg_6_1, arg_6_4)

		return arg_6_0:addCallback(var_6_0, arg_6_2, arg_6_3)
	end
end

function var_0_0.addCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 then
		arg_7_0._callbackId = arg_7_0._callbackId + 1

		local var_7_0 = arg_7_0._cmdCallbackTab[arg_7_1]

		if not var_7_0 then
			var_7_0 = {}
			arg_7_0._cmdCallbackTab[arg_7_1] = var_7_0
		end

		local var_7_1 = LuaGeneralCallback.getPool():getObject()

		var_7_1.callback = arg_7_2

		var_7_1:setCbObj(arg_7_3)

		var_7_1.id = arg_7_0._callbackId

		table.insert(var_7_0, var_7_1)

		return var_7_1.id
	end
end

function var_0_0.removeCallbackByCmd(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._cmdCallbackTab[arg_8_1]

	if not var_8_0 then
		return
	end

	arg_8_0._cmdCallbackTab[arg_8_1] = nil

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		LuaGeneralCallback.getPool():putObject(iter_8_1)
	end
end

function var_0_0.removeCallbackById(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._cmdCallbackTab) do
		if iter_9_1 then
			for iter_9_2 = #iter_9_1, 1, -1 do
				if arg_9_1 == iter_9_1[iter_9_2].id then
					LuaGeneralCallback.getPool():putObject(iter_9_1[iter_9_2])
					table.remove(iter_9_1, iter_9_2)

					return
				end
			end
		end
	end
end

function var_0_0.onReceiveMsg(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	local var_10_0 = arg_10_0["onReceive" .. arg_10_3]

	if var_10_0 then
		callWithCatch(var_10_0, arg_10_0, arg_10_1, arg_10_4)
	else
		logError(string.format("cmd_%d onReceive%s = nil, %s", arg_10_2, arg_10_3, arg_10_0.__cname))
	end

	if not arg_10_0._cmdCallbackTab then
		logError(string.format("cmd callbackDict = nil, %s => module_mvc.lua ", arg_10_0.__cname))

		return
	end

	local var_10_1 = arg_10_0._cmdCallbackTab[arg_10_2]

	if var_10_1 then
		arg_10_0._cmdCallbackTab[arg_10_2] = nil

		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			callWithCatch(iter_10_1.invoke, iter_10_1, arg_10_2, arg_10_1, arg_10_4)
			LuaGeneralCallback.getPool():putObject(iter_10_1)
		end
	end
end

return var_0_0
