module("modules.logic.fight.system.work.FightEffectBase", package.seeall)

local var_0_0 = class("FightEffectBase", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.skipAutoPlayData = false
end

function var_0_0.onAwake(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.onAwake(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0.fightStepData = arg_2_1
	arg_2_0.actEffectData = arg_2_2
end

function var_0_0._fightWorkSafeTimer(arg_3_0)
	if arg_3_0.fightStepData then
		local var_3_0 = string.format("战斗保底 fightwork ondone, className = %s , 步骤类型:%s, actId:%s", arg_3_0.__cname, arg_3_0.fightStepData.actType, arg_3_0.fightStepData.actId)

		logError(var_3_0)
	end

	arg_3_0:onDone(false)
end

function var_0_0.start(arg_4_0, arg_4_1)
	if arg_4_0.actEffectData then
		if arg_4_0.actEffectData:isDone() then
			arg_4_0:onDone(true)

			return
		else
			xpcall(arg_4_0.beforePlayEffectData, __G__TRACKBACK__, arg_4_0)

			if not arg_4_0.skipAutoPlayData then
				arg_4_0:playEffectData()
			end
		end
	end

	return var_0_0.super.start(arg_4_0, arg_4_1)
end

function var_0_0.getEffectData(arg_5_0)
	return arg_5_0.actEffectData
end

function var_0_0.beforeStart(arg_6_0)
	if arg_6_0.actEffectData then
		FightController.instance:dispatchEvent(FightEvent.InvokeFightWorkEffectType, arg_6_0.actEffectData.effectType)
	end

	FightSkillBehaviorMgr.instance:playSkillEffectBehavior(arg_6_0.fightStepData, arg_6_0.actEffectData)
end

function var_0_0.playEffectData(arg_7_0)
	FightDataHelper.playEffectData(arg_7_0.actEffectData)
end

function var_0_0.beforePlayEffectData(arg_8_0)
	return
end

function var_0_0.beforeClearWork(arg_9_0)
	return
end

function var_0_0.getAdjacentSameEffectList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	table.insert(var_10_0, {
		actEffectData = arg_10_0.actEffectData,
		fightStepData = arg_10_0.fightStepData
	})
	xpcall(arg_10_0.detectAdjacentSameEffect, __G__TRACKBACK__, arg_10_0, var_10_0, arg_10_1, arg_10_2)

	return var_10_0
end

function var_0_0.detectAdjacentSameEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.actEffectData.nextActEffectData

	while var_11_0 do
		local var_11_1 = var_11_0.effectType

		if arg_11_2 and arg_11_2[var_11_1] then
			if not var_11_0:isDone() then
				table.insert(arg_11_1, {
					actEffectData = var_11_0,
					fightStepData = arg_11_0.fightStepData
				})
			end

			if var_11_1 == FightEnum.EffectType.FIGHTSTEP then
				var_11_0 = var_11_0.fightStepNextActEffectData
			else
				var_11_0 = var_11_0.nextActEffectData
			end
		elseif var_11_1 == arg_11_0.actEffectData.effectType then
			if not var_11_0:isDone() then
				table.insert(arg_11_1, {
					actEffectData = var_11_0,
					fightStepData = arg_11_0.fightStepData
				})
			end

			var_11_0 = var_11_0.nextActEffectData
		elseif var_11_1 == FightEnum.EffectType.FIGHTSTEP then
			var_11_0 = var_11_0.nextActEffectData
		else
			return arg_11_1
		end
	end

	if arg_11_3 then
		local var_11_2 = FightDataHelper.roundMgr:getRoundData()

		if not var_11_2 then
			logError("找不到roundData")

			return arg_11_1
		end

		local var_11_3 = var_11_2.fightStep

		if not arg_11_0.fightStepData.custom_stepIndex then
			return arg_11_1
		end

		local var_11_4 = arg_11_0.fightStepData.custom_stepIndex + 1
		local var_11_5 = var_11_3[var_11_4]

		while var_11_5 do
			if FightHelper.isTimelineStep(var_11_5) then
				return arg_11_1
			end

			if #var_11_5.actEffect == 0 then
				var_11_4 = var_11_4 + 1
				var_11_5 = var_11_3[var_11_4]
			elseif arg_11_0:addSameEffectDetectNextStep(arg_11_1, arg_11_2, var_11_5) then
				var_11_4 = var_11_4 + 1
				var_11_5 = var_11_3[var_11_4]
			else
				return arg_11_1
			end
		end
	end

	return arg_11_1
end

function var_0_0.addSameEffectDetectNextStep(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	for iter_12_0, iter_12_1 in ipairs(arg_12_3.actEffect) do
		if arg_12_2 and arg_12_2[iter_12_1.effectType] then
			if not iter_12_1:isDone() then
				table.insert(arg_12_1, {
					actEffectData = iter_12_1,
					fightStepData = arg_12_3
				})
			end
		elseif iter_12_1.effectType == arg_12_0.actEffectData.effectType then
			if not iter_12_1:isDone() then
				table.insert(arg_12_1, {
					actEffectData = iter_12_1,
					fightStepData = arg_12_3
				})
			end
		elseif iter_12_1.effectType == FightEnum.EffectType.FIGHTSTEP then
			if not arg_12_0:addSameEffectDetectNextStep(arg_12_1, arg_12_2, iter_12_1.fightStep) then
				return false
			end
		else
			return false
		end
	end

	return true
end

return var_0_0
