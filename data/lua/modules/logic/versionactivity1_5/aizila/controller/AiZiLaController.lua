module("modules.logic.versionactivity1_5.aizila.controller.AiZiLaController", package.seeall)

slot0 = class("AiZiLaController", BaseController)

function slot0.onInit(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, slot0._onDestroyViewFinish, slot0)

	slot0._reShowViewAnim = {
		AiZiLaMapView = UIAnimationName.Open
	}

	slot0:reInit()
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0._onDestroyViewFinish(slot0)
	if #ViewMgr.instance:getOpenViewNameList() > 0 and slot0._reShowViewAnim[slot1[#slot1]] then
		AiZiLaHelper.playViewAnimator(slot2, slot0._reShowViewAnim[slot2])
	end
end

function slot0.reInit(slot0)
	slot0._openStoryIds = nil
end

function slot0.openStoryView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AiZiLaStoryView, {
		episodeId = slot1,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

function slot0.openMapView(slot0)
	slot0._enterStoryFinish = true
	slot0._openInfosFinish = false

	if not slot0:_checkStoryIds(slot0:_getOpenStoryIds()) then
		slot0._enterStoryFinish = false

		slot0:_playStoryIds(slot1, slot0._afterPlayEnterStory, slot0)
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleAiZiLa
	}, slot0._onTaskGet, slot0)
end

function slot0._onTaskGet(slot0)
	Activity144Rpc.instance:sendGet144InfosRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, slot0._onOpenMapViewRequest, slot0)
end

function slot0.playOpenStory(slot0)
	slot0:_playStoryIds(slot0:_getOpenStoryIds())
end

function slot0._playStoryIds(slot0, slot1, slot2, slot3)
	StoryController.instance:playStories(slot1, {
		mark = true,
		isReplay = false,
		hideStartAndEndDark = true
	}, slot2, slot3)
end

function slot0._afterPlayEnterStory(slot0)
	slot0._enterStoryFinish = true

	slot0:_checkOpenMapView()
end

function slot0._onOpenMapViewRequest(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0._openInfosFinish = true
		slot0._isInfoSettle = slot3.Act144InfoNO and slot3.Act144InfoNO.isSettle

		slot0:_checkOpenMapView()
	end
end

slot0.OPEN_MAPVIEW_INFO_SETTLE = "AiZiLaController.OPEN_MAPVIEW_INFO_SETTLE"

function slot0._checkOpenMapView(slot0)
	if slot0._enterStoryFinish and slot0._openInfosFinish then
		PermanentController.instance:jump2Activity(VersionActivity1_5Enum.ActivityId.EnterView)
		slot0:_onEnterViewIfNotOpened()
	end
end

function slot0._onEnterViewIfNotOpened(slot0)
	ViewMgr.instance:openView(ViewName.AiZiLaMapView)

	if slot0._isInfoSettle then
		slot0._isInfoSettle = false

		AiZiLaHelper.startBlock(uv0.OPEN_MAPVIEW_INFO_SETTLE)
		TaskDispatcher.runDelay(slot0._onInfoSettle, slot0, AiZiLaEnum.AnimatorTime.MapViewOpen)
	end
end

function slot0._onInfoSettle(slot0)
	AiZiLaGameModel.instance:reInit()
	Activity144Rpc.instance:sendAct144SettleEpisodeRequest(VersionActivity1_5Enum.ActivityId.AiZiLa, slot0._onInfoSettleRequest, slot0)
end

function slot0._onInfoSettleRequest(slot0, slot1, slot2, slot3)
	AiZiLaHelper.endBlock(uv0.OPEN_MAPVIEW_INFO_SETTLE)

	if slot2 == 0 then
		AiZiLaGameModel.instance:setEpisodeId(slot3.act144Episode.episodeId)
		AiZiLaGameModel.instance:settleEpisodeReply(slot3)

		if slot0._lastSettlePushMsg and slot0._lastSettlePushMsg.episodeId == slot3.act144Episode.episodeId then
			AiZiLaGameModel.instance:settlePush(slot0._lastSettlePushMsg)
		end

		AiZiLaGameController.instance:gameResult()
	end
end

function slot0._getOpenStoryIds(slot0)
	if not slot0._openStoryIds then
		slot0._openStoryIds = {}

		if AiZiLaConfig.instance:getStoryList(VersionActivity1_5Enum.ActivityId.AiZiLa) then
			for slot5, slot6 in ipairs(slot1) do
				if slot6.episodeId == AiZiLaEnum.OpenStoryEpisodeId then
					table.insert(slot0._openStoryIds, slot6.id)
				end
			end
		end
	end

	return slot0._openStoryIds
end

function slot0._checkStoryIds(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if not StoryModel.instance:isStoryHasPlayed(slot6) then
				return false
			end
		end
	end

	return true
end

function slot0.openEpsiodeDetailView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AiZiLaEpsiodeDetailView, {
		episodeId = slot1,
		actId = VersionActivity1_5Enum.ActivityId.AiZiLa
	})
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._actTaskMO == nil and slot2 then
		slot0._actTaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._actTaskMO = nil

	if slot0._actTaskMO and (slot1.id == AiZiLaEnum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		AiZiLaTaskListModel.instance:preFinish(slot1)

		slot0._actTaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._actTaskId = nil

	if slot0._actTaskId then
		if slot1 == AiZiLaEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.RoleAiZiLa)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.getInfosReply(slot0, slot1)
	AiZiLaModel.instance:getInfosReply(slot1)
end

function slot0.enterEpisodeReply(slot0, slot1)
	AiZiLaModel.instance:enterEpisodeReply(slot1)
end

function slot0.selectOptionReply(slot0, slot1)
	AiZiLaModel.instance:selectOptionReply(slot1)
end

function slot0.nextDayReply(slot0, slot1)
	AiZiLaModel.instance:nextDayReply(slot1)
end

function slot0.settleEpisodeReply(slot0, slot1)
	if AiZiLaGameModel.instance:getEpisodeId() ~= 0 and slot2 == slot1.act144Episode.episodeId then
		AiZiLaGameModel.instance:settleEpisodeReply(slot1)
		AiZiLaGameController.instance:gameResult()
	end
end

function slot0.settlePush(slot0, slot1)
	AiZiLaModel.instance:settlePush(slot1)

	slot0._lastSettlePushMsg = nil

	if AiZiLaGameModel.instance:getEpisodeId() ~= 0 and slot2 == slot1.episodeId then
		AiZiLaGameModel.instance:settlePush(slot1)
		AiZiLaGameController.instance:gameResult()
	else
		slot0._lastSettlePushMsg = slot1
	end
end

function slot0.upgradeEquipReply(slot0, slot1)
	AiZiLaModel.instance:upgradeEquipReply(slot1)
	slot0:dispatchEvent(AiZiLaEvent.OnEquipUpLevel, slot1.newEquipId)
end

function slot0.episodePush(slot0, slot1)
	AiZiLaModel.instance:episodePush(slot1)

	if AiZiLaGameModel.instance:getEpisodeId() ~= 0 and slot2 == slot1.act144Episode.episodeId then
		AiZiLaGameModel.instance:updateEpisode(slot1.act144Episode)
		AiZiLaGameController.instance:dispatchEvent(AiZiLaEvent.RefreshGameEpsiode)
	end

	slot0:dispatchEvent(AiZiLaEvent.EpisodePush)
end

function slot0.itemChangePush(slot0, slot1)
	AiZiLaModel.instance:itemChangePush(slot1)
end

slot0.instance = slot0.New()

return slot0
