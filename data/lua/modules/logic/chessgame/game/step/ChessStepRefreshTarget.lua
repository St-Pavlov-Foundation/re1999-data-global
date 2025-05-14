module("modules.logic.chessgame.game.step.ChessStepRefreshTarget", package.seeall)

local var_0_0 = class("ChessStepRefreshTarget", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	ChessGameModel.instance:setCompletedCount(arg_2_0.originData.completedCount)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
	arg_2_0:onDone(true)
end

return var_0_0
