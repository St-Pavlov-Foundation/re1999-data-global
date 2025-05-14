module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepGameFinish", package.seeall)

local var_0_0 = class("Va3ChessStepGameFinish", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processSelectObj()
	arg_1_0:processWinStatus()
end

function var_0_0.processSelectObj(arg_2_0)
	Va3ChessGameController.instance:setSelectObj(nil)
end

function var_0_0.processWinStatus(arg_3_0)
	Va3ChessGameModel.instance:setFailReason(arg_3_0.originData.failReason)

	if arg_3_0.originData.win == true then
		logNormal("game clear!")
		Va3ChessGameController.instance:gameClear()
	else
		arg_3_0:_gameOver()
	end
end

function var_0_0._gameOver(arg_4_0)
	Va3ChessGameController.instance:gameOver()
end

return var_0_0
