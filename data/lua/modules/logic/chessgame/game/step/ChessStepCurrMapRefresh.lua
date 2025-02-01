module("modules.logic.chessgame.game.step.ChessStepCurrMapRefresh", package.seeall)

slot0 = class("ChessStepCurrMapRefresh", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0)
	slot3 = slot0.originData.scene.currMapIndex

	if slot3 + 1 ~= ChessGameModel.instance:getNowMapIndex() then
		ChessGameController.instance:registerCallback(ChessGameEvent.GameLoadingMapStateUpdate, slot0._onLoadFinish, slot0)
		ChessGameController.instance:initServerMap(ChessModel.instance:getActId(), {
			episodeId = slot0.originData.scene.episodeId,
			currMapIndex = slot3,
			currentRound = slot0.originData.scene.currRound,
			completedCount = slot0.originData.scene.completedCount,
			interact = slot0.originData.scene.maps[slot3 + 1].interacts,
			win = slot0.originData.scene.win,
			dead = slot0.originData.scene.dead
		})
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start)
		ChessGameController.instance:setLoadingScene(true)
		ChessGameController.instance:dispatchEvent(ChessGameEvent.ChangeMap, ChessGameModel.instance:getNowMapResPath())
	end
end

function slot0._onLoadFinish(slot0, slot1)
	if slot1 == ChessGameEvent.LoadingMapState.Finish then
		slot0:onDone(true)
		ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, slot0._onLoadFinish, slot0)
	end
end

function slot0.cleanWork(slot0)
	ChessGameController.instance:unregisterCallback(ChessGameEvent.GameLoadingMapStateUpdate, slot0._onLoadFinish, slot0)
end

return slot0
