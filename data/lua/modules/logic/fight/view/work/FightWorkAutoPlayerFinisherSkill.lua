module("modules.logic.fight.view.work.FightWorkAutoPlayerFinisherSkill", package.seeall)

local var_0_0 = class("FightWorkAutoPlayerFinisherSkill", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0._beginRoundOp = arg_1_1
	arg_1_0.SAFETIME = 5
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if not arg_2_0._beginRoundOp then
		return arg_2_0:onDone(true)
	end

	FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, arg_2_0._beginRoundOp.toId)

	local var_2_0 = FightDataHelper.operationDataMgr:newOperation()

	var_2_0:playPlayerFinisherSkill(arg_2_0._beginRoundOp.param1, arg_2_0._beginRoundOp.toId)
	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, var_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, var_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
