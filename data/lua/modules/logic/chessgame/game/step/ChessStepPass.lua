module("modules.logic.chessgame.game.step.ChessStepPass", package.seeall)

local var_0_0 = class("ChessStepPass", BaseWork)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.originData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:processSelectObj()
	arg_2_0:onWin()
end

function var_0_0.processSelectObj(arg_3_0)
	ChessGameController.instance:setSelectObj(nil)
end

function var_0_0.onWin(arg_4_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.OnVictory)
	ChessGameController.instance:gameWin()
	arg_4_0:onDone(true)
end

return var_0_0
