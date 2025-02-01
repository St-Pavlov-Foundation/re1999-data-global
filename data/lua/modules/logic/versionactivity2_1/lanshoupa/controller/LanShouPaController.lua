module("modules.logic.versionactivity2_1.lanshoupa.controller.LanShouPaController", package.seeall)

slot0 = class("LanShouPaController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	ChessGameController.instance:registerCallback(ChessGameEvent.OnVictory, slot0._onVictory, slot0)
	ChessGameController.instance:registerCallback(ChessGameEvent.OnFail, slot0._onFail, slot0)
end

function slot0.reInit(slot0)
	slot0._waitActId = nil
	slot0._waitEpisodeId = nil
end

function slot0.openStoryView(slot0, slot1)
	if Activity164Model.instance:isEpisodeClear(slot1) then
		ViewMgr.instance:openView(ViewName.LanShouPaStoryView, {
			actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
			episodeId = slot1
		})
	end
end

slot0.ENTER_CHESS_GAME_BLOCK_KEY = "LanShouPaController.ENTER_CHESS_GAME_BLOCK_KEY"

function slot0.enterChessGame(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:startBlock(uv0.ENTER_CHESS_GAME_BLOCK_KEY)

	slot0._waitActId = slot1
	slot0._waitEpisodeId = slot2

	Activity164Model.instance:setCurEpisodeId(slot2)
	TaskDispatcher.cancelTask(slot0._onEnterChessGame, slot0, slot3)
	TaskDispatcher.runDelay(slot0._onEnterChessGame, slot0, slot3 or 0.1)
end

function slot0._onEnterChessGame(slot0)
	UIBlockMgr.instance:endBlock(uv0.ENTER_CHESS_GAME_BLOCK_KEY)

	if slot0._waitActId and slot0._waitEpisodeId then
		Activity164Rpc.instance:sendActStartEpisodeRequest(slot0._waitActId, slot0._waitEpisodeId, slot0._onOpenGame, slot0)
	end
end

function slot0.resetStartGame(slot0)
	slot1 = ChessModel.instance:getEpisodeId()

	if ChessModel.instance:getActId() and slot1 then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
		Activity164Rpc.instance:sendActReStartEpisodeRequest(slot2, slot1, slot0._onRestartCallback, slot0)
	end
end

slot0.RETURN_POINT_GAME_BLOCK_KEY = "LanShouPaController.RETURN_POINT_GAME_BLOCK_KEY"

function slot0.returnPointGame(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.RETURN_POINT_GAME_BLOCK_KEY)

	slot0._isLastCheckPoint = slot1 == ChessGameEnum.RollBack.CheckPoint

	if ChessModel.instance:getActId() then
		Activity164Rpc.instance:sendActRollBackRequest(slot2, ChessModel.instance:getEpisodeId(), slot1, slot0._onReurnPiontGame, slot0)
	end
end

function slot0._onRestartCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ChessController.onOpenGameStoryPlayOver()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameReset)
	else
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	end
end

function slot0._onReurnPiontGame(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.RETURN_POINT_GAME_BLOCK_KEY)

	if slot2 ~= 0 then
		ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Finish)
	else
		if slot3.dead then
			return
		end

		if slot0._isLastCheckPoint then
			ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
			TaskDispatcher.runDelay(slot0._eventReurnPiontGame, slot0, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
			ViewMgr.instance:closeView(ViewName.LanShouPaGameResultView)
			ChessStatController.instance:startStat()
		else
			slot0:_eventReurnPiontGame()
		end
	end
end

function slot0._eventReurnPiontGame(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GamePointReturn)
end

function slot0._onOpenGame(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if slot3.scene and slot3.scene.dead then
			Activity164Rpc.instance:sendActAbortRequest(slot3.activityId, slot3.episodeId, function ()
				Activity164Rpc.instance:sendActStartEpisodeRequest(uv0.activityId, uv0.episodeId, uv1._onOpenGame, uv1)
			end, slot0)

			return
		end

		ChessController.instance:initMapData(slot3.activityId, slot3.episodeId, slot3.scene)
		ChessGameController.instance:setViewName(ViewName.LanShouPaGameView)
		ChessController.instance:openGameView(slot1, slot2)
	end
end

function slot0.openActivity164GameView(slot0, slot1)
	ChessGameController.instance:enterGame(Activity164Config.instance:getEpisodeCo(VersionActivity2_1Enum.ActivityId.LanShouPa, slot1.episodeId).mapIds, ViewName.LanShouPaGameView)
end

function slot0.openTaskView(slot0)
	ViewMgr.instance:openView(ViewName.LanShouPaTaskView)
end

function slot0._onVictory(slot0)
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, true)
end

function slot0._onFail(slot0)
	ViewMgr.instance:openView(ViewName.LanShouPaGameResultView, false)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
