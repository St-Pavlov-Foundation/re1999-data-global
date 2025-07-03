module("modules.logic.fight.controller.replay.FightReplyWorkPlayerFinisherSkill", package.seeall)

local var_0_0 = class("FightReplyWorkPlayerFinisherSkill", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._beginRoundOp = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		arg_2_0:onDone(true)

		return
	end

	if not arg_2_0._beginRoundOp then
		return arg_2_0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, arg_2_0._beginRoundOp.toId)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 3)

	local var_2_0 = FightDataHelper.operationDatamgr:newOperation()

	var_2_0:playPlayerFinisherSkill(arg_2_0._beginRoundOp.param1, arg_2_0._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, var_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
