module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTargetUpdate", package.seeall)

slot0 = class("Va3ChessStepTargetUpdate", Va3ChessStepBase)

function slot0.start(slot0)
	Va3ChessGameModel.instance:setFinishedTargetNum(slot0.originData.targetNum)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TargetUpdate)
	slot0:finish()
end

return slot0
