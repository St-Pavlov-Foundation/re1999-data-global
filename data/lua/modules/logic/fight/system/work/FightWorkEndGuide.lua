module("modules.logic.fight.system.work.FightWorkEndGuide", package.seeall)

local var_0_0 = class("FightWorkEndGuide", BaseWork)

function var_0_0.onStart(arg_1_0)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause", FightEvent.OnGuideFightEndPause, FightEvent.OnGuideFightEndContinue, arg_1_0._done, arg_1_0)
end

function var_0_0._done(arg_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
