module("modules.logic.chessgame.game.step.ChessStepDead", package.seeall)

local var_0_0 = class("ChessStepDead", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:_onFail()
end

function var_0_0._onFail(arg_3_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnFail)
	ChessGameController.instance:gameOver()
	arg_3_0:onDone(true)
end

return var_0_0
