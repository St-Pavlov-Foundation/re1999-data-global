module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMap", package.seeall)

slot0 = class("Va3ChessStepNextMap", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:processNextMapStatus()
end

function slot0.processNextMapStatus(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.BeforeEnterNextMap)
	TaskDispatcher.runDelay(slot0.beginEnterNextMap, slot0, 0.5)
end

function slot0.beginEnterNextMap(slot0)
	slot4 = Va3ChessModel.instance:getMapId()

	if Va3ChessConfig.instance:getEpisodeCo(Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getEpisodeId()) and slot3.mapIds then
		slot4 = tonumber(string.split(slot3.mapIds, "#")[2])
	end

	Va3ChessGameModel.instance:recordLastMapRound()
	Va3ChessController.instance:initMapData(slot1, slot0.originData.act122Map)
	Va3ChessGameController.instance:enterChessGame(slot1, slot4, ViewName.Activity1_3ChessGameView)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
	slot0:finish()
end

return slot0
