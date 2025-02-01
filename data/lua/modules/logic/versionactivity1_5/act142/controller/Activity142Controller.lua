module("modules.logic.versionactivity1_5.act142.controller.Activity142Controller", package.seeall)

slot0 = class("Activity142Controller", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0:_endBlock()
end

function slot0.openMapView(slot0, slot1, slot2, slot3)
	slot0._tmpOpenMapViewCb = slot1
	slot0._tmpOpenMapViewCbObj = slot2
	slot0._tmpOpenMapViewCbParam = slot3

	Va3ChessRpcController.instance:sendGetActInfoRequest(Activity142Model.instance:getActivityId(), slot0._onOpenMapViewGetActInfoCb, slot0)
end

function slot0._onOpenMapViewGetActInfoCb(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	if Activity142Model.instance:isEpisodeOpen(Activity142Model.instance:getActivityId(), Activity142Enum.AUTO_ENTER_EPISODE_ID) and not Activity142Model.instance:isEpisodeClear(Activity142Enum.AUTO_ENTER_EPISODE_ID) then
		slot0:enterChessGame(Activity142Enum.AUTO_ENTER_EPISODE_ID, slot0._realOpenMapView, slot0)
	else
		slot0:_realOpenMapView()
	end
end

function slot0._realOpenMapView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity142
	})
	ViewMgr.instance:openView(ViewName.Activity142MapView, nil, true)

	if slot0._tmpOpenMapViewCb then
		slot0._tmpOpenMapViewCb(slot0._tmpOpenMapViewCbObj, slot0._tmpOpenMapViewCbParam)
	end

	slot0._tmpOpenMapViewCb = nil
	slot0._tmpOpenMapViewCbObj = nil
	slot0._tmpOpenMapViewCbParam = nil
end

function slot0.openStoryView(slot0, slot1)
	if Activity142Model.instance:isEpisodeClear(slot1) and Activity142Model.instance:getActivityId() then
		ViewMgr.instance:openView(ViewName.Activity142StoryView, {
			actId = slot2,
			episodeId = slot1
		})
	end
end

function slot0.enterChessGame(slot0, slot1, slot2, slot3)
	Va3ChessGameModel.instance:clearLastMapRound()

	slot4 = Activity142Model.instance:getActivityId()

	Va3ChessModel.instance:setActId(slot4)
	Activity142Model.instance:setCurEpisodeId(slot1)
	Activity142Helper.setAct142UIBlock(true)
	Va3ChessController.instance:startNewEpisode(slot1, slot0._afterEnterChessGame, slot0, ViewName.Activity142GameView, slot2, slot3)

	if not Va3ChessConfig.instance:isStoryEpisode(slot4, slot1) then
		Activity142StatController.instance:statStart()
	end
end

function slot0._afterEnterChessGame(slot0)
	slot0:_endBlock()
end

function slot0._endBlock(slot0)
	Activity142Helper.setAct142UIBlock(false)
end

function slot0.act142Back2CheckPoint(slot0, slot1, slot2)
	Activity142Rpc.instance:sendAct142CheckPointRequest(Activity142Model.instance:getActivityId(), true, slot1, slot2)
end

function slot0.act142ResetGame(slot0, slot1, slot2)
	if not Va3ChessModel.instance:getEpisodeId() then
		return
	end

	slot0._tmpResetCallback = slot1
	slot0._tmpResetCallbackObj = slot2

	Va3ChessModel.instance:setActId(Activity142Model.instance:getActivityId())
	Va3ChessGameModel.instance:clearLastMapRound()
	Va3ChessController.instance:startResetEpisode(slot3, slot0._act142ResetCallback, slot0, ViewName.Activity142GameView)
end

function slot0._act142ResetCallback(slot0)
	if slot0._tmpResetCallback then
		slot0._tmpResetCallback(slot0._tmpResetCallbackObj)

		slot0._tmpResetCallback = nil
		slot0._tmpResetCallbackObj = nil
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameReset)
end

function slot0.delayRequestGetReward(slot0, slot1, slot2)
	if slot0._tmpTaskMO == nil and slot2 then
		slot0._tmpTaskMO = slot2

		TaskDispatcher.runDelay(slot0.requestGetReward, slot0, slot1)
	end
end

function slot0.requestGetReward(slot0)
	if slot0._tmpTaskMO == nil then
		return
	end

	if slot0._tmpTaskMO.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity142)
	elseif slot0._tmpTaskMO:haveRewardToGet() then
		TaskRpc.instance:sendFinishTaskRequest(slot0._tmpTaskMO.id)
	end

	slot0._tmpTaskMO = nil
end

function slot0.dispatchAllTaskItemGotReward(slot0)
	slot0:dispatchEvent(Activity142Event.OneClickClaimReward)
end

function slot0.setPlayedUnlockAni(slot0, slot1)
	if not Activity142Model.instance:getPlayerCacheData() then
		return
	end

	slot2[slot1] = true

	Activity142Model.instance:saveCacheData()
end

function slot0.havePlayedUnlockAni(slot0, slot1)
	if not slot1 then
		return false
	end

	if not Activity142Model.instance:getPlayerCacheData() then
		return slot2
	end

	return slot3[slot1] or false
end

slot0.instance = slot0.New()

return slot0
