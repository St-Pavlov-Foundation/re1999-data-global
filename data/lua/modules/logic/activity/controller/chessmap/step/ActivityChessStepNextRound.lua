module("modules.logic.activity.controller.chessmap.step.ActivityChessStepNextRound", package.seeall)

local var_0_0 = class("ActivityChessStepNextRound", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	local var_2_0 = ActivityChessGameController.instance.event

	if var_2_0 then
		var_2_0:setCurEvent(nil)
	end

	local var_2_1 = arg_2_0.originData.currentRound

	ActivityChessGameModel.instance:setRound(var_2_1)
	ActivityChessGameController.instance:tryResumeSelectObj()
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentRoundUpdate)
	var_0_0.super.finish(arg_2_0)
end

return var_0_0
