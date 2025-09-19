module("modules.logic.survival.model.SurvivalTalentGroupBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalTalentGroupBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.allUnlockIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.unlockTalentIds) do
		arg_1_0.allUnlockIds[iter_1_1] = true
	end

	arg_1_0.groups = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.groups) do
		local var_1_0 = SurvivalTalentGroupMo.New()

		var_1_0.parent = arg_1_0

		var_1_0:init(iter_1_3)

		arg_1_0.groups[var_1_0.groupId] = var_1_0
	end
end

function var_0_0.getTalentGroup(arg_2_0, arg_2_1)
	if not arg_2_0.groups[arg_2_1] then
		arg_2_0.groups[arg_2_1] = SurvivalTalentGroupMo.New()
		arg_2_0.groups[arg_2_1].parent = arg_2_0
		arg_2_0.groups[arg_2_1].groupId = arg_2_1
	end

	return arg_2_0.groups[arg_2_1]
end

function var_0_0.updateGroupInfo(arg_3_0, arg_3_1)
	arg_3_0:getTalentGroup(arg_3_1.groupId):init(arg_3_1)
end

function var_0_0.unLockTalent(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0.allUnlockIds[iter_4_1] = true
	end
end

function var_0_0.isEquipAll(arg_5_0)
	local var_5_0 = tabletool.len(arg_5_0.allUnlockIds)
	local var_5_1 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_0.groups) do
		var_5_1 = var_5_1 + tabletool.len(iter_5_1.talents)
	end

	return var_5_0 == var_5_1
end

return var_0_0
