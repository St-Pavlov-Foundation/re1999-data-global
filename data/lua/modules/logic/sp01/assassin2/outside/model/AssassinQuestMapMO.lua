module("modules.logic.sp01.assassin2.outside.model.AssassinQuestMapMO", package.seeall)

local var_0_0 = class("AssassinQuestMapMO")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1

	arg_1_0:clearQuestData()
end

function var_0_0.clearQuestData(arg_2_0)
	arg_2_0._finishQuestDict = {}
	arg_2_0._unlockQuestDict = {}
end

function var_0_0.unlockQuest(arg_3_0, arg_3_1)
	arg_3_0._unlockQuestDict[arg_3_1] = true
end

function var_0_0.finishQuest(arg_4_0, arg_4_1)
	arg_4_0._finishQuestDict[arg_4_1] = true
	arg_4_0._unlockQuestDict[arg_4_1] = nil
end

function var_0_0.getStatus(arg_5_0)
	local var_5_0 = arg_5_0:getProgress()
	local var_5_1 = AssassinEnum.MapStatus.Unlocked

	if var_5_0 >= AssassinEnum.Const.MapQuestMaxProgress then
		var_5_1 = AssassinEnum.MapStatus.Finished
	end

	return var_5_1
end

function var_0_0.getProgress(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = AssassinConfig.instance:getQuestListInMap(arg_6_0.id)

	if var_6_1 then
		var_6_0 = #var_6_1
	end

	local var_6_2 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0._finishQuestDict) do
		var_6_2 = var_6_2 + 1
	end

	local var_6_3 = Mathf.Clamp(var_6_2 / var_6_0, 0, 1)

	return tonumber(string.format("%.2f", var_6_3))
end

function var_0_0.getFinishQuestCount(arg_7_0, arg_7_1)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0._finishQuestDict) do
		local var_7_1 = AssassinConfig.instance:getQuestType(iter_7_0)

		if not arg_7_1 or arg_7_1 == var_7_1 then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0
end

function var_0_0.getAllUnlockQuestCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFinishQuestCount(arg_8_1)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._unlockQuestDict) do
		local var_8_1 = AssassinConfig.instance:getQuestType(iter_8_0)

		if not arg_8_1 or arg_8_1 == var_8_1 then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.getMapUnlockQuestIdList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0._unlockQuestDict) do
		var_9_0[#var_9_0 + 1] = iter_9_0
	end

	return var_9_0
end

function var_0_0.getMapFinishQuestIdList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0._finishQuestDict) do
		var_10_0[#var_10_0 + 1] = iter_10_0
	end

	return var_10_0
end

function var_0_0.isUnlockQuest(arg_11_0, arg_11_1)
	return arg_11_0._unlockQuestDict[arg_11_1] and true or false
end

function var_0_0.isFinishQuest(arg_12_0, arg_12_1)
	return arg_12_0._finishQuestDict[arg_12_1] and true or false
end

return var_0_0
