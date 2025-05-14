module("modules.logic.chessgame.game.step.ChessStepUpdateRound", package.seeall)

local var_0_0 = class("ChessStepUpdateRound", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:finish()
end

function var_0_0.finish(arg_3_0)
	local var_3_0 = ChessGameController.instance.eventMgr
	local var_3_1 = arg_3_0.originData.currRound

	ChessGameModel.instance:setRound(var_3_1)

	if not ChessGameModel.instance:isTalking() then
		ChessGameController.instance:tryResumeSelectObj()
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentRoundUpdate)

	if var_3_0 then
		var_3_0:setCurEvent(nil)
	end

	ChessGameController.instance:forceRefreshObjSelectedView()
	arg_3_0:onDone(true)
end

return var_0_0
