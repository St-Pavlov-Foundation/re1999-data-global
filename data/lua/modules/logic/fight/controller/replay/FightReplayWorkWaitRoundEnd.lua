module("modules.logic.fight.controller.replay.FightReplayWorkWaitRoundEnd", package.seeall)

local var_0_0 = class("FightReplayWorkWaitRoundEnd", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundEnd, arg_2_0)
end

function var_0_0._onRoundEnd(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_4_0._onRoundEnd, arg_4_0)
end

return var_0_0
