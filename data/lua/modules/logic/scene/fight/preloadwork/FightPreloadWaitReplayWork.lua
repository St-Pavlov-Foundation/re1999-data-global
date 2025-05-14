module("modules.logic.scene.fight.preloadwork.FightPreloadWaitReplayWork", package.seeall)

local var_0_0 = class("FightPreloadWaitReplayWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = FightModel.instance:getFightParam()

	if var_1_0 and var_1_0.isReplay then
		if FightReplayModel.instance:isReplay() then
			arg_1_0:onDone(true)
		else
			FightController.instance:registerCallback(FightEvent.StartReplay, arg_1_0._onStartReplay, arg_1_0)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onStartReplay(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.StartReplay, arg_3_0._onStartReplay, arg_3_0)
end

return var_0_0
