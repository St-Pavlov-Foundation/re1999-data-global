module("modules.logic.versionactivity1_5.enter.controller.VersionActivity1_5EnterController", package.seeall)

slot0 = class("VersionActivity1_5EnterController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_5EnterView) then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0:openVersionActivityEnterView(slot1, slot2)
end

function slot0.openVersionActivityEnterView(slot0, slot1, slot2)
	slot0.openedCallback = slot1
	slot0.openedCallbackObj = slot2

	slot0:_enterVersionActivityView(ViewName.VersionActivity1_5EnterView, VersionActivity1_5Enum.ActivityId.EnterView, slot0._openVersionActivityEnterView, slot0)
end

function slot0._onFinishStory(slot0)
	if ActivityHelper.getActivityStatus(VersionActivity1_5Enum.ActivityId.EnterView) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0:_openVersionActivityEnterView()
end

function slot0._openVersionActivityEnterView(slot0)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_5Enum.ActivityId.EnterView) then
		if not (ActivityModel.instance:getActMO(VersionActivity1_5Enum.ActivityId.EnterView) and slot1.config and slot1.config.storyId) then
			logError(string.format("act id %s dot config story id", slot2))

			slot2 = 100010
		end

		StoryController.instance:playStory(slot2, {
			isVersionActivityPV = true
		}, slot0._onFinishStory, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5EnterView, {
		actId = VersionActivity1_5Enum.ActivityId.EnterView,
		activityIdListWithGroup = VersionActivity1_5Enum.EnterViewActIdListWithGroup,
		mainActIdList = VersionActivity1_5Enum.EnterViewMainActIdList,
		actId2AmbientDict = VersionActivity1_5Enum.ActId2Ambient,
		actId2OpenAudioDict = VersionActivity1_5Enum.ActId2OpenAudio
	})

	if slot0.openedCallback then
		slot0.openedCallback(slot0.openedCallbackObj)

		slot0.openedCallback = nil
		slot0.openedCallbackObj = nil
	end
end

function slot0.directOpenVersionActivityEnterView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivity1_5EnterView, VersionActivity1_5Enum.ActivityId.EnterView, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_5EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_5Enum.ActivityId.EnterView,
			activityIdListWithGroup = VersionActivity1_5Enum.EnterViewActIdListWithGroup,
			mainActIdList = VersionActivity1_5Enum.EnterViewMainActIdList,
			actId2AmbientDict = VersionActivity1_5Enum.ActId2Ambient,
			actId2OpenAudioDict = VersionActivity1_5Enum.ActId2OpenAudio
		})
	end, slot0)
end

function slot0.openStoreView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivity1_5StoreView, VersionActivity1_5Enum.ActivityId.DungeonStore, slot0._openStoreView, slot0)
end

function slot0._openStoreView(slot0, slot1, slot2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot2, function ()
		ViewMgr.instance:openView(uv0, {
			actId = uv1
		})
	end)
end

function slot0.openSeasonStoreView(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	slot0:_enterVersionActivityView(SeasonViewHelper.getViewName(slot1, Activity104Enum.ViewName.StoreView), Activity104Enum.SeasonStore[slot1], slot0._openStoreView, slot0)
end

function slot0.openTaskView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_5Enum.ActivityId.Act113, slot0._openTaskView, slot0)
end

function slot0._openTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function ()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function slot0._enterVersionActivityView(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		if slot6 then
			GameFacade.showToast(slot6, slot7)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2)

		return
	end

	ViewMgr.instance:openView(slot1)
end

function slot0.GetActivityPrefsKey(slot0)
	return VersionActivity1_5Enum.ActivityId.EnterView .. slot0
end

function slot0.GetActivityPrefsKeyWithUser(slot0)
	return PlayerModel.instance:getPlayerPrefsKey(uv0.GetActivityPrefsKey(slot0))
end

slot0.instance = slot0.New()

return slot0
