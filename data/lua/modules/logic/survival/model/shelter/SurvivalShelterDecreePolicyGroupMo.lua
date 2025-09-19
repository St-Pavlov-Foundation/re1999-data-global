module("modules.logic.survival.model.shelter.SurvivalShelterDecreePolicyGroupMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterDecreePolicyGroupMo")

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.list = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.policies) do
		local var_2_0 = SurvivalShelterDecreePolicyMo.New()

		var_2_0:init(iter_2_1.id)
		var_2_0:updateInfo(iter_2_1)
		table.insert(arg_2_0.list, var_2_0)
	end
end

function var_0_0.getPolicyList(arg_3_0)
	return arg_3_0.list
end

function var_0_0.isEmpty(arg_4_0)
	return arg_4_0.list == nil or next(arg_4_0.list) == nil
end

function var_0_0.isFinish(arg_5_0)
	if arg_5_0:isEmpty() then
		return false
	end

	local var_5_0 = arg_5_0:getPolicyList()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if not iter_5_1:isFinish() then
			return false
		end
	end

	return true
end

function var_0_0.isAllNotFinish(arg_6_0)
	if arg_6_0:isEmpty() then
		return false
	end

	local var_6_0 = arg_6_0:getPolicyList()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if iter_6_1:isFinish() then
			return false
		end
	end

	return true
end

return var_0_0
