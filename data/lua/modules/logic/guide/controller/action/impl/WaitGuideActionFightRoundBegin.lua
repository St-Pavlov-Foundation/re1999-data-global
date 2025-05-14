module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundBegin", package.seeall)

local var_0_0 = class("WaitGuideActionFightRoundBegin", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, arg_1_0._onRoundStart, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundStart, arg_1_0)
end

function var_0_0._onRoundStart(arg_2_0)
	local var_2_0 = FightModel.instance:getCurStage()

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Distribute1Card) or var_2_0 == FightEnum.Stage.Distribute or var_2_0 == FightEnum.Stage.Card then
		arg_2_0:clearWork()
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, arg_3_0._onRoundStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_3_0._onRoundStart, arg_3_0)
end

return var_0_0
