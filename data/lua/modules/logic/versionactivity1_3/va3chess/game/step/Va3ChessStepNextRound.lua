module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextRound", package.seeall)

local var_0_0 = class("Va3ChessStepNextRound", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	local var_2_0 = Va3ChessGameController.instance.event
	local var_2_1 = arg_2_0.originData.currentRound

	Va3ChessGameModel.instance:setRound(var_2_1)
	Va3ChessGameController.instance:tryResumeSelectObj()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentRoundUpdate)

	if var_2_0 then
		var_2_0:setCurEvent(nil)
	end

	Va3ChessGameController.instance:forceRefreshObjSelectedView()
	var_0_0.super.finish(arg_2_0)
end

return var_0_0
