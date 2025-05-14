module("modules.logic.fight.controller.replay.FightReplayWorkWaitCardStage", package.seeall)

local var_0_0 = class("FightReplayWorkWaitCardStage", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		arg_2_0:onDone(true)
	else
		FightController.instance:registerCallback(FightEvent.OnStageChange, arg_2_0._onStageChange, arg_2_0)
	end
end

function var_0_0._onStageChange(arg_3_0, arg_3_1)
	if arg_3_1 == FightEnum.Stage.Card then
		FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_3_0._onStageChange, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_4_0._onStageChange, arg_4_0)
end

return var_0_0
