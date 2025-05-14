module("modules.logic.rouge.model.rpcmo.RougeUnlockSkillMO", package.seeall)

local var_0_0 = pureTable("RougeUnlockSkillMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.type
	arg_1_0.idMap = arg_1_0:_listToMap(arg_1_1.ids)
end

function var_0_0._listToMap(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return {}
	end

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		var_2_0[iter_2_1] = iter_2_1
	end

	return var_2_0
end

function var_0_0.isSkillUnlock(arg_3_0, arg_3_1)
	return arg_3_0.idMap and arg_3_0.idMap[arg_3_1] ~= nil
end

function var_0_0.onNewSkillUnlock(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0.idMap[arg_4_1] = true
end

return var_0_0
