module("modules.logic.fight.system.work.FightEffectBase", package.seeall)

local var_0_0 = class("FightEffectBase", FightWorkItem)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.onAwake(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._fightStepMO = arg_1_1
	arg_1_0._actEffectMO = arg_1_2
end

function var_0_0._fightWorkSafeTimer(arg_2_0)
	if arg_2_0._fightStepMO then
		local var_2_0 = string.format("战斗保底 fightwork ondone, className = %s , 步骤类型:%s, actId:%s", arg_2_0.__cname, arg_2_0._fightStepMO.actType, arg_2_0._fightStepMO.actId)

		logError(var_2_0)
	end

	arg_2_0:onDone(false)
end

function var_0_0.start(arg_3_0, arg_3_1)
	if arg_3_0._actEffectMO then
		if arg_3_0._actEffectMO:isDone() then
			arg_3_0:onDone(true)

			return
		else
			xpcall(arg_3_0.beforePlayEffectData, __G__TRACKBACK__, arg_3_0)
			arg_3_0:playEffectData()
		end
	end

	return var_0_0.super.start(arg_3_0, arg_3_1)
end

function var_0_0.getEffectMO(arg_4_0)
	return arg_4_0._actEffectMO
end

function var_0_0.beforeStart(arg_5_0)
	if arg_5_0._actEffectMO then
		FightController.instance:dispatchEvent(FightEvent.InvokeFightWorkEffectType, arg_5_0._actEffectMO.effectType)
	end

	FightSkillBehaviorMgr.instance:playSkillEffectBehavior(arg_5_0._fightStepMO, arg_5_0._actEffectMO)
end

function var_0_0.playEffectData(arg_6_0)
	FightDataHelper.playEffectData(arg_6_0._actEffectMO)
end

function var_0_0.beforePlayEffectData(arg_7_0)
	return
end

function var_0_0.beforeClearWork(arg_8_0)
	return
end

function var_0_0.getAdjacentSameEffectList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	table.insert(var_9_0, {
		effect = arg_9_0._actEffectMO,
		stepMO = arg_9_0._fightStepMO
	})
	xpcall(arg_9_0.detectAdjacentSameEffect, __G__TRACKBACK__, arg_9_0, var_9_0, arg_9_1, arg_9_2)

	return var_9_0
end

function var_0_0.detectAdjacentSameEffect(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._actEffectMO.NEXTEFFECT

	while var_10_0 do
		local var_10_1 = var_10_0.effectType

		if arg_10_2 and arg_10_2[var_10_1] then
			if not var_10_0:isDone() then
				table.insert(arg_10_1, {
					effect = var_10_0,
					stepMO = arg_10_0._fightStepMO
				})
			end

			if var_10_1 == FightEnum.EffectType.FIGHTSTEP then
				var_10_0 = var_10_0.FIGHTSTEPNEXTEFFECT
			else
				var_10_0 = var_10_0.NEXTEFFECT
			end
		elseif var_10_1 == arg_10_0._actEffectMO.effectType then
			if not var_10_0:isDone() then
				table.insert(arg_10_1, {
					effect = var_10_0,
					stepMO = arg_10_0._fightStepMO
				})
			end

			var_10_0 = var_10_0.NEXTEFFECT
		elseif var_10_1 == FightEnum.EffectType.FIGHTSTEP then
			var_10_0 = var_10_0.NEXTEFFECT
		else
			return arg_10_1
		end
	end

	if arg_10_3 then
		local var_10_2 = FightModel.instance:getCurRoundMO()

		if not var_10_2 then
			logError("找不到roundmo")

			return arg_10_1
		end

		local var_10_3 = var_10_2.fightStepMOs

		if not arg_10_0._fightStepMO.custom_stepIndex then
			return arg_10_1
		end

		local var_10_4 = arg_10_0._fightStepMO.custom_stepIndex + 1
		local var_10_5 = var_10_3[var_10_4]

		while var_10_5 do
			if FightHelper.isTimelineStep(var_10_5) then
				return arg_10_1
			end

			if #var_10_5.actEffectMOs == 0 then
				var_10_4 = var_10_4 + 1
				var_10_5 = var_10_3[var_10_4]
			elseif arg_10_0:addSameEffectDetectNextStep(arg_10_1, arg_10_2, var_10_5) then
				var_10_4 = var_10_4 + 1
				var_10_5 = var_10_3[var_10_4]
			else
				return arg_10_1
			end
		end
	end

	return arg_10_1
end

function var_0_0.addSameEffectDetectNextStep(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0, iter_11_1 in ipairs(arg_11_3.actEffectMOs) do
		if arg_11_2 and arg_11_2[iter_11_1.effectType] then
			if not iter_11_1:isDone() then
				table.insert(arg_11_1, {
					effect = iter_11_1,
					stepMO = arg_11_3
				})
			end
		elseif iter_11_1.effectType == arg_11_0._actEffectMO.effectType then
			if not iter_11_1:isDone() then
				table.insert(arg_11_1, {
					effect = iter_11_1,
					stepMO = arg_11_3
				})
			end
		elseif iter_11_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			if not arg_11_0:addSameEffectDetectNextStep(arg_11_1, arg_11_2, iter_11_1.cus_stepMO) then
				return false
			end
		else
			return false
		end
	end

	return true
end

return var_0_0
