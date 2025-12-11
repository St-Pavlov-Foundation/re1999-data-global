module("modules.logic.fight.controller.replay.FightReplayWorkWaitCardStage", package.seeall)

local var_0_0 = class("FightReplayWorkWaitCardStage", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		arg_2_0:onDone(true)
	else
		FightController.instance:registerCallback(FightEvent.StageChanged, arg_2_0.onStageChange, arg_2_0)
	end
end

function var_0_0.onStageChange(arg_3_0, arg_3_1)
	if arg_3_1 == FightStageMgr.StageType.Operate then
		FightController.instance:unregisterCallback(FightEvent.StageChanged, arg_3_0.onStageChange, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, arg_4_0.onStageChange, arg_4_0)
end

return var_0_0
