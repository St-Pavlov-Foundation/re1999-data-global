module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

local var_0_0 = class("FightASFDFlow", BaseFlow)

var_0_0.DelayWaitTime = 61

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.curIndex = arg_1_3
	arg_1_0.asfdContext = arg_1_0:getContext(arg_1_1)
	arg_1_0.nextStepData = arg_1_2
end

function var_0_0.createNormalSeq(arg_2_0)
	local var_2_0 = arg_2_0.fightStepData

	arg_2_0._sequence = FlowSequence.New()

	arg_2_0._sequence:addWork(FightWorkCreateASFDEmitter.New(var_2_0))

	local var_2_1 = FlowSequence.New()

	var_2_1:addWork(FightWorkMissileASFD.New(var_2_0, arg_2_0.asfdContext))

	local var_2_2 = FlowParallel.New()
	local var_2_3 = arg_2_0:checkNeedAddWaitDoneWork(arg_2_0.nextStepData)

	if var_2_3 then
		var_2_1:addWork(FightWorkMissileASFDDone.New(var_2_0))
		var_2_2:addWork(FightWorkWaitASFDArrivedDone.New(var_2_0))
	end

	var_2_2:addWork(var_2_1)
	arg_2_0._sequence:addWork(var_2_2)
	arg_2_0._sequence:addWork(FightWorkASFDEffectFlow.New(var_2_0))

	if var_2_3 then
		arg_2_0._sequence:addWork(FightWorkASFDDone.New(var_2_0))
	else
		arg_2_0._sequence:addWork(FightWorkASFDContinueDone.New(var_2_0))
	end
end

function var_0_0.createPullOutSeq(arg_3_0)
	arg_3_0._sequence = FlowSequence.New()

	local var_3_0 = FlowParallel.New()

	var_3_0:addWork(FightWorkASFDClearEmitter.New(arg_3_0.fightStepData))
	var_3_0:addWork(FightWorkASFDPullOut.New(arg_3_0.fightStepData))
	var_3_0:addWork(FightWorkASFDEffectFlow.New(arg_3_0.fightStepData))
	arg_3_0._sequence:addWork(var_3_0)
	arg_3_0._sequence:addWork(FightWorkASFDDone.New(arg_3_0.fightStepData))
end

function var_0_0.getContext(arg_4_0, arg_4_1)
	local var_4_0 = FightASFDHelper.getStepContext(arg_4_1, arg_4_0.curIndex)

	if var_4_0 then
		return var_4_0
	end

	logError("not found EMITTER FIGHT NOTIFY !!!")

	return {
		splitNum = 0,
		emitterAttackNum = 1,
		emitterAttackMaxNum = 2
	}
end

function var_0_0.checkNeedAddWaitDoneWork(arg_5_0, arg_5_1)
	if arg_5_0:checkHasMonsterChangeEffectType(arg_5_0.fightStepData) then
		return true
	end

	if not arg_5_1 then
		return true
	end

	if FightASFDHelper.isALFPullOutStep(arg_5_1, arg_5_0.curIndex) then
		return true
	end

	if not FightHelper.isASFDSkill(arg_5_1.actId) then
		return true
	end

	return false
end

function var_0_0.checkHasMonsterChangeEffectType(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return false
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.actEffect) do
		if iter_6_1.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if iter_6_1.effectType == FightEnum.EffectType.FIGHTSTEP and arg_6_0:checkHasMonsterChangeEffectType(iter_6_1.fightStepData) then
			return true
		end
	end

	return false
end

function var_0_0.onStart(arg_7_0)
	if FightASFDHelper.isALFPullOutStep(arg_7_0.fightStepData, arg_7_0.curIndex) then
		arg_7_0:createPullOutSeq()
	else
		arg_7_0:createNormalSeq()
	end

	arg_7_0._sequence:registerDoneListener(arg_7_0._flowDone, arg_7_0)
	arg_7_0._sequence:start()
end

function var_0_0.hasDone(arg_8_0)
	return not arg_8_0._sequence or arg_8_0._sequence.status ~= WorkStatus.Running
end

function var_0_0.stopSkillFlow(arg_9_0)
	if arg_9_0._sequence and arg_9_0._sequence.status == WorkStatus.Running then
		arg_9_0._sequence:stop()
		arg_9_0._sequence:unregisterDoneListener(arg_9_0._flowDone, arg_9_0)

		arg_9_0._sequence = nil
	end
end

function var_0_0._flowDone(arg_10_0)
	if arg_10_0._sequence then
		arg_10_0._sequence:unregisterDoneListener(arg_10_0._flowDone, arg_10_0)

		arg_10_0._sequence = nil
	end

	arg_10_0:onDone(true)
end

function var_0_0.clearWork(arg_11_0)
	if arg_11_0._sequence then
		arg_11_0._sequence:stop()
		arg_11_0._sequence:unregisterDoneListener(arg_11_0._flowDone, arg_11_0)

		arg_11_0._sequence = nil
	end
end

return var_0_0
