module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

local var_0_0 = class("FightASFDFlow", BaseFlow)

var_0_0.DelayWaitTime = 61

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.stepMo = arg_1_1
	arg_1_0.curIndex = arg_1_3
	arg_1_0._sequence = FlowSequence.New()

	arg_1_0._sequence:addWork(FightWorkCreateASFDEmitter.New(arg_1_1))

	local var_1_0 = FlowSequence.New()

	var_1_0:addWork(FightWorkMissileASFD.New(arg_1_1, arg_1_0.curIndex))

	local var_1_1 = FlowParallel.New()
	local var_1_2 = arg_1_0:checkNeedAddWaitDoneWork(arg_1_2)

	if var_1_2 then
		var_1_0:addWork(FightWorkMissileASFDDone.New(arg_1_1))
		var_1_1:addWork(FightWorkWaitASFDArrivedDone.New(arg_1_1))
	end

	var_1_1:addWork(var_1_0)
	arg_1_0._sequence:addWork(var_1_1)
	arg_1_0._sequence:addWork(FightWorkASFDEffectFlow.New(arg_1_1))

	if var_1_2 then
		arg_1_0._sequence:addWork(FightWorkASFDDone.New(arg_1_1))
	else
		arg_1_0._sequence:addWork(FightWorkASFDContinueDone.New(arg_1_1))
	end
end

function var_0_0.checkNeedAddWaitDoneWork(arg_2_0, arg_2_1)
	if arg_2_0:checkHasMonsterChangeEffectType(arg_2_0.stepMo) then
		return true
	end

	if not arg_2_1 then
		return true
	end

	if not FightHelper.isASFDSkill(arg_2_1.actId) then
		return true
	end

	return false
end

function var_0_0.checkHasMonsterChangeEffectType(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return false
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.actEffectMOs) do
		if iter_3_1.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if iter_3_1.effectType == FightEnum.EffectType.FIGHTSTEP and arg_3_0:checkHasMonsterChangeEffectType(iter_3_1.cus_stepMO) then
			return true
		end
	end

	return false
end

function var_0_0.onStart(arg_4_0)
	arg_4_0._sequence:registerDoneListener(arg_4_0._flowDone, arg_4_0)
	arg_4_0._sequence:start()
end

function var_0_0.hasDone(arg_5_0)
	return not arg_5_0._sequence or arg_5_0._sequence.status ~= WorkStatus.Running
end

function var_0_0.stopSkillFlow(arg_6_0)
	if arg_6_0._sequence and arg_6_0._sequence.status == WorkStatus.Running then
		arg_6_0._sequence:stop()
		arg_6_0._sequence:unregisterDoneListener(arg_6_0._flowDone, arg_6_0)

		arg_6_0._sequence = nil
	end
end

function var_0_0._flowDone(arg_7_0)
	if arg_7_0._sequence then
		arg_7_0._sequence:unregisterDoneListener(arg_7_0._flowDone, arg_7_0)

		arg_7_0._sequence = nil
	end

	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	if arg_8_0._sequence then
		arg_8_0._sequence:stop()
		arg_8_0._sequence:unregisterDoneListener(arg_8_0._flowDone, arg_8_0)

		arg_8_0._sequence = nil
	end
end

return var_0_0
