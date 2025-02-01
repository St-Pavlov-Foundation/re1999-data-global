module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepNextMapAct120", package.seeall)

slot0 = class("Va3ChessStepNextMapAct120", Va3ChessStepBase)

function slot0.start(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start)
	TaskDispatcher.cancelTask(slot0._onProcessNextMapStatus, slot0)
	TaskDispatcher.runDelay(slot0._onProcessNextMapStatus, slot0, 0.5)
end

function slot0._onProcessNextMapStatus(slot0)
	slot4 = Va3ChessModel.instance:getMapId()

	if Va3ChessConfig.instance:getEpisodeCo(Va3ChessModel.instance:getActId(), Va3ChessModel.instance:getEpisodeId()) and slot3.mapIds then
		slot4 = tonumber(string.split(slot3.mapIds, "#")[2])
	end

	slot0.originData.id = slot2

	for slot10, slot11 in ipairs(cjson.decode(cjson.encode(slot0.originData)).interactObjects) do
		if type(slot11.data) == "table" then
			slot11.data = cjson.encode(slot11.data)
		end
	end

	if not slot6.finishInteracts then
		slot6.finishInteracts = Va3ChessGameModel.instance:findInteractFinishIds()
	end

	if not slot6.allFinishInteracts then
		slot6.allFinishInteracts = Va3ChessGameModel.instance:findInteractFinishIds(true)
	end

	if not slot6.currentRound then
		slot6.currentRound = Va3ChessGameModel.instance:getRound()
	end

	Va3ChessGameController.instance:initServerMap(slot1, slot6)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameMapDataUpdate)
	Va3ChessGameController.instance:enterChessGame(slot1, slot4)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EnterNextMap)
end

function slot0.finish(slot0)
	TaskDispatcher.cancelTask(slot0._onProcessNextMapStatus, slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._onProcessNextMapStatus, slot0)
	uv0.super.dispose(slot0)
end

return slot0
