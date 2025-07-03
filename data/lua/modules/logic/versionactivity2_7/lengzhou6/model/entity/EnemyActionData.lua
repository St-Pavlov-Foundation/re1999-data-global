module("modules.logic.versionactivity2_7.lengzhou6.model.entity.EnemyActionData", package.seeall)

local var_0_0 = class("EnemyActionData")

function var_0_0.ctor(arg_1_0)
	arg_1_0._round = 0
	arg_1_0._curBehaviorId = 1
	arg_1_0._loopIndex = 1
	arg_1_0._behaviorData = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._config = LengZhou6Config.instance:getEliminateBattleEnemyBehavior(arg_2_1)
	arg_2_0._curBehaviorId = 1

	if arg_2_0._behaviorData == nil then
		arg_2_0._behaviorData = {}
	end

	for iter_2_0 = 1, #arg_2_0._config do
		local var_2_0 = arg_2_0._config[iter_2_0]
		local var_2_1 = EnemyBehaviorData.New()

		var_2_1:init(var_2_0)
		table.insert(arg_2_0._behaviorData, var_2_1)
	end
end

function var_0_0.initLoopIndex(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._startIndex = arg_3_1
	arg_3_0._endIndex = arg_3_2
end

function var_0_0._haveNeedActionSkill(arg_4_0)
	arg_4_0._round = arg_4_0._round + 1

	local var_4_0 = arg_4_0:calCurResidueCd()

	if var_4_0 and var_4_0 == 0 then
		return true
	end

	return false
end

function var_0_0.calCurResidueCd(arg_5_0)
	local var_5_0 = arg_5_0:getCurBehaviorCd()

	return math.max(var_5_0 - arg_5_0._round, 0)
end

function var_0_0.getCurBehaviorCd(arg_6_0)
	local var_6_0 = arg_6_0._behaviorData[arg_6_0._curBehaviorId]

	if var_6_0 then
		return var_6_0:cd()
	end

	return 0
end

function var_0_0.updateCurBehaviorId(arg_7_0)
	local var_7_0 = #arg_7_0._behaviorData

	if arg_7_0._endIndex ~= nil and arg_7_0._loopIndex > 1 then
		var_7_0 = arg_7_0._endIndex
	end

	if arg_7_0._curBehaviorId == var_7_0 then
		arg_7_0._loopIndex = arg_7_0._loopIndex + 1
		arg_7_0._curBehaviorId = arg_7_0._startIndex == nil and 1 or arg_7_0._startIndex
	else
		arg_7_0._curBehaviorId = arg_7_0._curBehaviorId + 1
	end
end

function var_0_0.setCurBehaviorId(arg_8_0, arg_8_1)
	arg_8_0._curBehaviorId = arg_8_1
end

function var_0_0.getCurBehaviorId(arg_9_0)
	return arg_9_0._curBehaviorId
end

function var_0_0.getCurRound(arg_10_0)
	return arg_10_0._round
end

function var_0_0.setCurRound(arg_11_0, arg_11_1)
	arg_11_0._round = arg_11_1
end

function var_0_0.getCurBehavior(arg_12_0)
	return arg_12_0._behaviorData[arg_12_0._curBehaviorId] or nil
end

function var_0_0.getSkillList(arg_13_0)
	if arg_13_0:_haveNeedActionSkill() then
		local var_13_0 = arg_13_0:getCurBehavior()

		if var_13_0 == nil then
			logError("curBehavior is nil: index " .. arg_13_0._curBehaviorId)

			return nil
		end

		local var_13_1 = var_13_0:getSkillList(true)

		arg_13_0._round = arg_13_0._round - var_13_0:cd()

		arg_13_0:updateCurBehaviorId()

		return var_13_1
	end

	return nil
end

return var_0_0
