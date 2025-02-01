module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessController", package.seeall)

slot0 = class("Activity1_3ChessController", BaseController)

function slot0.openMapView(slot0, slot1, slot2, slot3, slot4)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity122
	})
	Activity122Rpc.instance:sendGetActInfoRequest(VersionActivity1_3Enum.ActivityId.Act304, function ()
		ViewMgr.instance:openView(ViewName.Activity1_3ChessMapView, {
			chapterId = uv0
		}, true)

		if uv1 then
			uv1(uv2, uv3)
		end
	end)
end

function slot0.openStoryView(slot0, slot1)
	if Activity122Model.instance:isEpisodeClear(slot1) then
		ViewMgr.instance:openView(ViewName.Activity1_3ChessStoryView, {
			actId = VersionActivity1_3Enum.ActivityId.Act304,
			episodeId = slot1
		})
	end
end

function slot0.requestEnterChessGame(slot0, slot1, slot2)
	Va3ChessGameModel.instance:clearLastMapRound()

	slot0._isEnterPassedEpisode = Activity122Model.instance:isEpisodeClear(slot1)

	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)
	Activity122Model.instance:setCurEpisodeId(slot1)
	slot0:dispatchEvent(Activity1_3ChessEvent.BeginEnterChessGame, slot1)
	Stat1_3Controller.instance:bristleStatStart()
	UIBlockMgr.instance:startBlock(Activity1_3ChessEnum.UIBlockKey)

	if slot2 then
		slot0._enterEpisodeId = slot1

		TaskDispatcher.runDelay(slot0.delayRequestEnterChessGame, slot0, slot2)
	else
		Va3ChessController.instance:startNewEpisode(slot1, slot0._afterEnterGame, slot0, ViewName.Activity1_3ChessGameView)
	end
end

function slot0.delayRequestEnterChessGame(slot0)
	TaskDispatcher.cancelTask(slot0.delayRequestEnterChessGame, slot0)
	Va3ChessController.instance:startNewEpisode(slot0._enterEpisodeId, slot0._afterEnterGame, slot0, ViewName.Activity1_3ChessGameView)
end

function slot0.beginResetChessGame(slot0, slot1, slot2, slot3)
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessModel.instance:setActId(VersionActivity1_3Enum.ActivityId.Act304)

	slot0._enterChessCallback = slot2
	slot0._enterChessCallbackObj = slot3
	slot0._resetChessGame = true

	Va3ChessController.instance:startResetEpisode(slot1, slot0._afterEnterGame, slot0, ViewName.Activity1_3ChessGameView)
end

function slot0._afterEnterGame(slot0)
	UIBlockMgr.instance:endBlock(Activity1_3ChessEnum.UIBlockKey)

	slot1 = Va3ChessModel.instance:getEpisodeId()

	if slot0._enterChessCallback then
		slot0._enterChessCallback(slot0._enterChessCallbackObj)

		slot0._enterChessCallback = nil
		slot0._enterChessCallbackObj = nil
	end

	if slot0._resetChessGame then
		slot0:dispatchEvent(Activity1_3ChessEvent.AfterResetChessGame)

		slot0._resetChessGame = nil
	end
end

function slot0.requestReadChessGame(slot0, slot1, slot2, slot3)
	slot0._readChessCallback = slot2
	slot0._readChessCallbackObj = slot3

	Activity122Rpc.instance:sendAct122CheckPointRequest(slot1, true, slot0._readCallback, slot0)
end

function slot0.requestBackChessGame(slot0, slot1)
	Activity122Rpc.instance:sendAct122CheckPointRequest(slot1, false, slot0._readCallback, slot0)
end

function slot0._readCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot4 = slot3.map
		slot6 = slot3.activityId

		Va3ChessController.instance:initMapData(slot6, slot4)
		Va3ChessGameController.instance:enterChessGame(slot6, slot4.mapId, ViewName.Activity1_3ChessGameView)
	end

	if slot0._readChessCallback then
		slot0._readChessCallback(slot0._readChessCallbackObj)

		slot0._readChessCallback = nil
		slot0._readChessCallbackObj = nil
	end

	slot0:dispatchEvent(Activity1_3ChessEvent.OnReadChessGame)
end

function slot0.isEpisodeOpen(slot0, slot1)
	for slot7 = 1, #Activity122Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act304) do
		if slot3[slot7].id == slot1 and uv0.isOpenDay(slot8.id) and (slot8.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(slot8.id) or Activity122Model.instance:isEpisodeClear(slot8.preEpisode)) then
			return true
		end
	end

	return false
end

function slot0.checkEpisodeIsOpenByChapterId(slot0, slot1)
	for slot7 = 1, #Activity122Config.instance:getEpisodeList(VersionActivity1_3Enum.ActivityId.Act304) do
		if slot3[slot7].chapterId == slot1 and uv0.isOpenDay(slot8.id) and (slot8.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(slot8.id) or Activity122Model.instance:isEpisodeClear(slot8.preEpisode)) then
			return true
		end
	end

	return false
end

function slot0.isOpenDay(slot0)
	slot1 = VersionActivity1_3Enum.ActivityId.Act304
	slot3 = Activity122Config.instance:getEpisodeCo(slot1, slot0)

	if ActivityModel.instance:getActMO(slot1) and slot3 then
		if ServerTime.now() < slot2:getRealStartTimeStamp() + (slot3.openDay - 1) * 24 * 60 * 60 then
			return false, slot4 - slot5
		end
	else
		return false, -1
	end

	return true
end

function slot0.isChapterOpen(slot0, slot1)
	if not uv0.getFristEpisodeCoByChapterId(slot1) then
		return false, -1
	end

	if Activity122Model.instance:isEpisodeClear(slot2.id) then
		return true
	end

	slot3, slot4 = uv0.isOpenDay(slot2.id)

	return slot3 and Activity122Model.instance:isEpisodeClear(slot2.preEpisode), slot4 or 0
end

function slot0.getFristEpisodeCoByChapterId(slot0)
	return Activity122Config.instance:getChapterEpisodeList(VersionActivity1_3Enum.ActivityId.Act304, slot0) and slot2[1]
end

function slot0.isEnterPassedEpisode(slot0)
	return slot0._isEnterPassedEpisode
end

function slot0.getLimitTimeStr()
	if ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act304) then
		return string.format(luaLang("activity_warmup_remain_time"), slot0:getRemainTimeStr())
	end

	return string.format(luaLang("activity_warmup_remain_time"), "0")
end

function slot0.setReviewStory(slot0, slot1)
	slot0._isReviewStory = slot1
end

function slot0.isReviewStory(slot0)
	return slot0._isReviewStory
end

function slot0.getCurChessMapCfg()
	return Activity122Config.instance:getMapCo(Va3ChessGameModel.instance:getActId(), Va3ChessGameModel.instance:getMapId())
end

slot1 = -100

function slot0.delayRequestGetReward(slot0, slot1, slot2)
	if slot0._taskMO == nil and slot2 then
		slot0._taskMO = slot2

		TaskDispatcher.runDelay(slot0.requestGetReward, slot0, slot1)
	end
end

function slot0.requestGetReward(slot0)
	if slot0._taskMO == nil then
		return
	end

	if slot0._taskMO.id == uv0 then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity122)
	elseif slot0._taskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(slot0._taskMO.id)
	end

	slot0._taskMO = nil
end

function slot0.dispatchAllTaskItemGotReward(slot0)
	uv0.instance:dispatchEvent(Activity1_3ChessEvent.OneClickClaimReward)
end

function slot0.showToastByEpsodeId(slot0, slot1, slot2)
	if not Activity122Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act304, slot1) then
		logNormal(string.format("can not find v1a3 activity episodeCfg. actId:%s episodeId:%s", VersionActivity1_3Enum.ActivityId.Act304, slot1))

		return
	end

	slot5, slot6 = uv0.isOpenDay(slot4.id)

	if not slot5 then
		GameFacade.showToast(slot2 and ToastEnum.Va3Act120ChapterNotOpenTime or ToastEnum.Va3Act120EpisodeNotOpenTime)

		return
	end

	if not (slot4.preEpisode == 0 or Activity122Model.instance:isEpisodeClear(slot4.preEpisode)) then
		GameFacade.showToast(ToastEnum.Va3Act124PreEpisodeNotOpen, Activity122Config.instance:getEpisodeCo(slot4.activityId, slot4.preEpisode) and slot8.name or slot4.preEpisode)
	end
end

function slot0.checkHasReward(slot0)
	if TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122) ~= nil then
		for slot6, slot7 in ipairs(Activity122Config.instance:getTaskByActId(Va3ChessEnum.ActivityId.Act122)) do
			if slot1[slot7.id] and slot8.hasFinished and slot8.finishCount == 0 then
				return true
			end
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
