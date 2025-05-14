module("modules.logic.rouge.map.model.rpcmo.RougeFightEventMO", package.seeall)

local var_0_0 = class("RougeFightEventMO", RougeBaseEventMO)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:updateSurpriseAttackList()
end

function var_0_0.updateSurpriseAttackList(arg_2_0)
	arg_2_0.surpriseAttackList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.jsonData.surpriseAttackList or {}) do
		table.insert(arg_2_0.surpriseAttackList, iter_2_1)
	end
end

function var_0_0.update(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:updateSurpriseAttackList()
end

function var_0_0.getSurpriseAttackList(arg_4_0)
	return arg_4_0.surpriseAttackList
end

function var_0_0.__tostring(arg_5_0)
	return var_0_0.super.__tostring(arg_5_0)
end

return var_0_0
