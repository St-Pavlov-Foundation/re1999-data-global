module("modules.logic.versionactivity1_3.jialabona.controller.JiaLaBoNaController", package.seeall)

slot0 = class("JiaLaBoNaController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._waitActId = nil
	slot0._waitEpisodeId = nil
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._act120TaskMO == nil and slot2 then
		slot0._act120TaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._act120TaskMO = nil

	if slot0._act120TaskMO and (slot1.id == JiaLaBoNaEnum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		Activity120TaskListModel.instance:preFinish(slot1)

		slot0._act120TaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, JiaLaBoNaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._act120TaskId = nil

	if slot0._act120TaskId then
		if slot1 == JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity120)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.oneClaimReward(slot0, slot1)
	for slot6, slot7 in pairs(Activity120TaskListModel.instance:getList()) do
		if slot7:alreadyGotReward() and slot7.id ~= JiaLaBoNaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(slot7.id)
		end
	end
end

function slot0.openMapView(slot0, slot1, slot2, slot3, slot4)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity120
	}, function ()
		Activity120Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act306)
		Activity120Model.instance:setCurEpisodeId(uv0)
		ViewMgr.instance:openView(ViewName.JiaLaBoNaMapView, {
			episodeId = uv0
		})

		if uv1 then
			uv1(uv2, uv3)
		end
	end)
end

function slot0.openStoryView(slot0, slot1)
	if Activity120Model.instance:isEpisodeClear(slot1) then
		ViewMgr.instance:openView(ViewName.JiaLaBoNaStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act306,
			episodeId = slot1
		})
	end
end

function slot0.isEnterBforeClear(slot0)
	return slot0._isBeforeClear
end

slot0.ENTER_CHESS_GAME_BLOCK_KEY = "JiaLaBoNaController.ENTER_CHESS_GAME_BLOCK_KEY"

function slot0.enterChessGame(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:startBlock(uv0.ENTER_CHESS_GAME_BLOCK_KEY)

	slot0._waitActId = slot1
	slot0._waitEpisodeId = slot2
	slot0._isBeforeClear = Activity120Model.instance:isEpisodeClear(slot2)

	Activity120Model.instance:setCurEpisodeId(slot2)
	TaskDispatcher.cancelTask(slot0._onEnterChessGame, slot0, slot3)
	TaskDispatcher.runDelay(slot0._onEnterChessGame, slot0, slot3 or 0.1)
end

function slot0._onEnterChessGame(slot0)
	UIBlockMgr.instance:endBlock(uv0.ENTER_CHESS_GAME_BLOCK_KEY)

	if slot0._waitActId and slot0._waitEpisodeId then
		Activity120Rpc.instance:sendActStartEpisodeRequest(slot0._waitActId, slot0._waitEpisodeId, slot0._onOpenGame, slot0)
	end
end

function slot0.resetStartGame(slot0)
	slot1 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() and slot1 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		Activity120Rpc.instance:sendActStartEpisodeRequest(slot2, slot1, slot0._onRestartCallback, slot0)
	end
end

slot0.RETURN_POINT_GAME_BLOCK_KEY = "JiaLaBoNaController.RETURN_POINT_GAME_BLOCK_KEY"

function slot0.returnPointGame(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.RETURN_POINT_GAME_BLOCK_KEY)

	slot0._isLastCheckPoint = slot1

	if Va3ChessModel.instance:getActId() then
		Activity120Rpc.instance:sendActCheckPointRequest(slot2, slot1, slot0._onReurnPiontGame, slot0)
	end
end

function slot0._onRestartCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		Va3ChessController.onOpenGameStoryPlayOver()
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
	else
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	end
end

function slot0._onReurnPiontGame(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.RETURN_POINT_GAME_BLOCK_KEY)

	if slot2 ~= 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Finish)
	elseif slot0._isLastCheckPoint then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
		TaskDispatcher.runDelay(slot0._eventReurnPiontGame, slot0, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
		ViewMgr.instance:closeView(ViewName.JiaLaBoNaGameResultView)
	else
		slot0:_eventReurnPiontGame()
	end
end

function slot0._eventReurnPiontGame(slot0)
	uv0.instance:dispatchEvent(JiaLaBoNaEvent.GamePointReturn)
end

function slot0._onOpenGame(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		Activity120Model.instance:increaseCount(slot3.map.id)
		Va3ChessController.instance:initMapData(slot3.activityId, slot3.map)
		Va3ChessGameController.instance:setViewName(ViewName.JiaLaBoNaGameView)
		Stat1_3Controller.instance:jiaLaBoNaStatStart()
		Va3ChessController.instance:openGameView(slot1, slot2)
	end
end

slot0.instance = slot0.New()

return slot0
