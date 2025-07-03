module("modules.logic.fight.view.work.FightAutoPlayAssistBossCardWork", package.seeall)

local var_0_0 = class("FightAutoPlayAssistBossCardWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._beginRoundOp = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, arg_2_0._beginRoundOp.toId)
	end

	if not arg_2_0._beginRoundOp then
		return arg_2_0:onDone(true)
	end

	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 3)

	local var_2_0 = FightDataHelper.operationDataMgr:newOperation()

	var_2_0:playAssistBossHandCard(arg_2_0._beginRoundOp.param1, arg_2_0._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayAssistBossCardFlowDone, var_2_0)
	FightDataHelper.paTaMgr:playAssistBossSkillBySkillId(var_2_0.param1)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossPowerChange)
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	logError("自动战斗打协助boss牌超时")
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
