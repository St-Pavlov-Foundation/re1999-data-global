module("modules.logic.versionactivity2_5.autochess.flow.AutoChessEffectWork", package.seeall)

local var_0_0 = class("AutoChessEffectWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.effect = arg_1_1
	arg_1_0.mgr = AutoChessEntityMgr.instance
	arg_1_0.chessMo = AutoChessModel.instance:getChessMo()

	if arg_1_0.effect.effectType == AutoChessEnum.EffectType.NextFightStep then
		logError("异常:NextFightStep类型的数据不该出现在这里")
	end
end

function var_0_0.markSkillEffect(arg_2_0, arg_2_1)
	arg_2_0.skillEffectId = arg_2_1
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	if arg_3_0.skillEffectId then
		local var_3_0 = arg_3_0.mgr:tryGetEntity(arg_3_0.effect.targetId)

		if var_3_0 then
			var_3_0.effectComp:playEffect(arg_3_0.skillEffectId)
		end
	end

	local var_3_1 = AutoChessEffectHandleFunc.instance:getHandleFunc(arg_3_0.effect.effectType)

	if var_3_1 then
		var_3_1(arg_3_0)
	end
end

function var_0_0.onStop(arg_4_0)
	if arg_4_0.damageWork then
		arg_4_0.damageWork:onStopInternal()
	else
		TaskDispatcher.cancelTask(arg_4_0.delayAttack, arg_4_0)
		TaskDispatcher.cancelTask(arg_4_0.delayFloatLeader, arg_4_0)
		TaskDispatcher.cancelTask(arg_4_0.finishWork, arg_4_0)
	end
end

function var_0_0.onResume(arg_5_0)
	if arg_5_0.damageWork then
		arg_5_0.damageWork:onResumeInternal()
	else
		arg_5_0:finishWork()
	end
end

function var_0_0.clearWork(arg_6_0)
	if arg_6_0.damageWork then
		arg_6_0.damageWork:unregisterDoneListener(arg_6_0.finishWork, arg_6_0)

		arg_6_0.damageWork = nil
	end

	TaskDispatcher.cancelTask(arg_6_0.delayAttack, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.delayFloatLeader, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.finishWork, arg_6_0)

	arg_6_0.effect = nil
	arg_6_0.mgr = nil
	arg_6_0.chessMo = nil
	arg_6_0.skillEffectId = nil
end

function var_0_0.finishWork(arg_7_0)
	if arg_7_0.effect.effectType == AutoChessEnum.EffectType.ChessDie then
		AutoChessEntityMgr.instance:removeEntity(arg_7_0.effect.targetId)
	end

	arg_7_0:onDone(true)
end

function var_0_0.delayAttack(arg_8_0)
	local var_8_0 = 0
	local var_8_1 = arg_8_0.mgr:getLeaderEntity(arg_8_0.effect.fromId)
	local var_8_2 = arg_8_0.mgr:getLeaderEntity(arg_8_0.effect.targetId)

	if var_8_1 and var_8_2 then
		var_8_0 = var_8_1:ranged(var_8_2.transform.position, 20002)
	end

	TaskDispatcher.runDelay(arg_8_0.delayFloatLeader, arg_8_0, var_8_0)
end

function var_0_0.delayFloatLeader(arg_9_0)
	local var_9_0 = arg_9_0.mgr:getLeaderEntity(arg_9_0.effect.targetId)

	if var_9_0 then
		var_9_0:floatHp(arg_9_0.effect.effectNum)
	end

	TaskDispatcher.runDelay(arg_9_0.finishWork, arg_9_0, 1)
end

return var_0_0
