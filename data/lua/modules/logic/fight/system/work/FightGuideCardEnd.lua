module("modules.logic.fight.system.work.FightGuideCardEnd", package.seeall)

local var_0_0 = class("FightGuideCardEnd", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideCardEndPause", FightEvent.OnGuideCardEndPause, FightEvent.OnGuideCardEndContinue, arg_2_0._done, arg_2_0)
end

function var_0_0._done(arg_3_0)
	arg_3_0:onDone(true)
end

return var_0_0
