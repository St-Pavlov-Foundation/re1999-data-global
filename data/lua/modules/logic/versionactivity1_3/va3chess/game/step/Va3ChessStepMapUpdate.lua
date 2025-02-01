module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMapUpdate", package.seeall)

slot0 = class("Va3ChessStepMapUpdate", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:processMapUpdate()
end

function slot0.processMapUpdate(slot0)
	Va3ChessGameController.instance:updateServerMap(Va3ChessModel.instance:getActId(), slot0.originData)
	slot0:finish()
end

return slot0
