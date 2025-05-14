module("modules.common.others.BaseRpcExtend", package.seeall)

local var_0_0 = class("BaseRpcExtend", BaseRpc)

function var_0_0.onInitInternal(arg_1_0)
	arg_1_0._getter = GameUtil.getUniqueTb(10000)
	arg_1_0._waitCallBackDict = {}

	var_0_0.super.onInitInternal(arg_1_0)
end

function var_0_0.reInitInternal(arg_2_0)
	arg_2_0._waitCallBackDict = {}

	var_0_0.super.reInitInternal(arg_2_0)
end

function var_0_0.sendMsg(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = LuaSocketMgr.instance:getCmdByPbStructName(arg_3_1.__cname)

	if not arg_3_0._waitCallBackDict[var_3_0] then
		arg_3_0._waitCallBackDict[var_3_0] = {}
	end

	if arg_3_0._waitCallBackDict[var_3_0][1] ~= nil then
		var_0_0.super.sendMsg(arg_3_0, arg_3_1, nil, nil, arg_3_4)
	else
		var_0_0.super.sendMsg(arg_3_0, arg_3_1, arg_3_0.onReceiveMsgExtend, arg_3_0, arg_3_4)
	end

	if arg_3_2 then
		local var_3_1 = LuaGeneralCallback.getPool():getObject()

		var_3_1.callback = arg_3_2

		var_3_1:setCbObj(arg_3_3)

		var_3_1.id = arg_3_0._getter()

		table.insert(arg_3_0._waitCallBackDict[var_3_0], var_3_1)

		return var_3_1.id
	else
		table.insert(arg_3_0._waitCallBackDict[var_3_0], false)
	end
end

function var_0_0.removeCallbackByIdExtend(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._waitCallBackDict) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			if iter_4_3 and iter_4_3.id == arg_4_1 then
				iter_4_1[iter_4_2] = false

				LuaGeneralCallback.getPool():putObject(iter_4_3)

				return
			end
		end
	end
end

function var_0_0.onReceiveMsgExtend(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._waitCallBackDict[arg_5_1] then
		return
	end

	local var_5_0 = table.remove(arg_5_0._waitCallBackDict[arg_5_1], 1)

	if arg_5_0._waitCallBackDict[arg_5_1][1] ~= nil then
		arg_5_0:addCallback(arg_5_1, arg_5_0.onReceiveMsgExtend, arg_5_0)
	end

	if var_5_0 then
		var_5_0:invoke(arg_5_1, arg_5_2, arg_5_3)
		LuaGeneralCallback.getPool():putObject(var_5_0)
	end
end

return var_0_0
