module("modules.logic.survival.model.shelter.SurvivalShelterDecreeMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterDecreeMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.box = arg_1_2
	arg_1_0.curState = nil
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0:updateCurPolicy(arg_2_1.curr)
	arg_2_0:updatePolicyInfos(arg_2_1.options)
end

function var_0_0.updateCurPolicy(arg_3_0, arg_3_1)
	if not arg_3_0.curPolicyGroup then
		arg_3_0.curPolicyGroup = SurvivalShelterDecreePolicyGroupMo.New()

		arg_3_0.curPolicyGroup:init()
	end

	arg_3_0.curPolicyGroup:updateInfo(arg_3_1)
end

function var_0_0.updatePolicyInfos(arg_4_0, arg_4_1)
	arg_4_0.policyGroupList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:updatePolicyInfo(iter_4_0, iter_4_1)
	end
end

function var_0_0.updatePolicyInfo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.policyGroupList[arg_5_1]

	if not var_5_0 then
		var_5_0 = SurvivalShelterDecreePolicyGroupMo.New()

		var_5_0:init()

		arg_5_0.policyGroupList[arg_5_1] = var_5_0
	end

	var_5_0:updateInfo(arg_5_2)
end

function var_0_0.getPolicGroupList(arg_6_0)
	return arg_6_0.policyGroupList
end

function var_0_0.getCurPolicyGroup(arg_7_0)
	return arg_7_0.curPolicyGroup
end

function var_0_0.isCurPolicyEmpty(arg_8_0)
	return arg_8_0.curPolicyGroup == nil or arg_8_0.curPolicyGroup:isEmpty()
end

function var_0_0.hasOptions(arg_9_0)
	return next(arg_9_0.policyGroupList) ~= nil
end

function var_0_0.isFinish(arg_10_0)
	if arg_10_0:isCurPolicyEmpty() then
		return false
	end

	return arg_10_0.curPolicyGroup:isFinish()
end

function var_0_0.isAllPolicyNotFinish(arg_11_0)
	if arg_11_0:isCurPolicyEmpty() then
		return false
	end

	return arg_11_0.curPolicyGroup:isAllNotFinish()
end

function var_0_0.getCurPolicyNeedTags(arg_12_0)
	if arg_12_0:isCurPolicyEmpty() then
		return {}
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.curPolicyGroup:getPolicyList()) do
		if iter_12_1.co and not iter_12_1:isFinish() then
			local var_12_1 = string.splitToNumber(iter_12_1.co.tags, "#")

			if var_12_1 then
				for iter_12_2, iter_12_3 in ipairs(var_12_1) do
					var_12_0[iter_12_3] = 1
				end
			end
		end
	end

	return var_12_0
end

function var_0_0.getCurStatus(arg_13_0)
	if arg_13_0.curState == nil then
		arg_13_0:updateCurStatus()
	end

	return arg_13_0.curState
end

function var_0_0.updateCurStatus(arg_14_0)
	arg_14_0.curState = arg_14_0:getRealStatus()
end

function var_0_0.getRealStatus(arg_15_0)
	if arg_15_0:isCurPolicyEmpty() then
		return SurvivalEnum.ShelterDecreeStatus.Normal
	end

	if arg_15_0.box:isFinish(arg_15_0.id) then
		return SurvivalEnum.ShelterDecreeStatus.Finish
	end

	return SurvivalEnum.ShelterDecreeStatus.UnFinish
end

return var_0_0
