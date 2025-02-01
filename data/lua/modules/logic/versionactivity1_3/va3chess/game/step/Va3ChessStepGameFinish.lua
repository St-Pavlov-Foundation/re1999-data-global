module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepGameFinish", package.seeall)

slot0 = class("Va3ChessStepGameFinish", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:processSelectObj()
	slot0:processWinStatus()
end

function slot0.processSelectObj(slot0)
	Va3ChessGameController.instance:setSelectObj(nil)
end

function slot0.processWinStatus(slot0)
	Va3ChessGameModel.instance:setFailReason(slot0.originData.failReason)

	if slot0.originData.win == true then
		logNormal("game clear!")
		Va3ChessGameController.instance:gameClear()
	else
		slot0:_gameOver()
	end
end

function slot0._gameOver(slot0)
	Va3ChessGameController.instance:gameOver()
end

return slot0
