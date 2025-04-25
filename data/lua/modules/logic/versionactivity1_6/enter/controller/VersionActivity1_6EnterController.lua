module("modules.logic.versionactivity1_6.enter.controller.VersionActivity1_6EnterController", package.seeall)

slot0 = class("VersionActivity1_6EnterController", BaseController)

function slot0.onInit(slot0)
	slot0.selectActId = nil
end

function slot0.reInit(slot0)
	slot0.selectActId = nil
end

function slot0.setSelectActId(slot0, slot1)
	slot0.selectActId = slot1
end

function slot0.getSelectActId(slot0)
	return slot0.selectActId
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2, slot3, slot4)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_5EnterView) then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0:openVersionActivityEnterView(slot1, slot2, slot3, slot4)
end

function slot0.openVersionActivityEnterView(slot0, slot1, slot2, slot3, slot4)
	slot0.openedCallback = slot1
	slot0.openedCallbackObj = slot2
	slot0.actId = slot3

	slot0:_enterVersionActivityView(ViewName.VersionActivity2_5EnterView, VersionActivity2_5Enum.ActivityId.EnterView, slot0._openVersionActivityEnterView, slot0, {
		jumpActId = slot3,
		enterVideo = slot4
	})
end

function slot0._onFinishStory(slot0, slot1)
	if ActivityHelper.getActivityStatus(VersionActivity1_6Enum.ActivityId.EnterView) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0:_openVersionActivityEnterView(nil, , slot1)
end

function slot0._openVersionActivityEnterView(slot0, slot1, slot2, slot3)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_6Enum.ActivityId.EnterView) then
		if not (ActivityModel.instance:getActMO(VersionActivity1_6Enum.ActivityId.EnterView) and slot4.config and slot4.config.storyId) then
			logError(string.format("act id %s dot config story id", slot5))

			slot5 = 100010
		end

		StoryController.instance:playStory(slot5, {
			isVersionActivityPV = true
		}, slot0._onFinishStory, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterView, {
		activityIdList = VersionActivity1_6Enum.EnterViewActIdList,
		actId = slot0.actId,
		jumpActId = slot3 and slot3.jumpActId,
		enterVideo = slot3 and slot3.enterVideo
	})

	if slot0.openedCallback then
		slot0.openedCallback(slot0.openedCallbackObj)

		slot0.openedCallback = nil
		slot0.openedCallbackObj = nil
	end
end

function slot0.directOpenVersionActivityEnterView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivity1_6EnterView, VersionActivity1_6Enum.ActivityId.EnterView, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_6EnterView, {
			skipOpenAnim = true,
			actId = VersionActivity1_6Enum.ActivityId.EnterView,
			activityIdList = VersionActivity1_6Enum.EnterViewActIdList
		})
	end, slot0)
end

function slot0.openStoreView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivity1_6StoreView, VersionActivity1_6Enum.ActivityId.DungeonStore, slot0._openStoreView, slot0)
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
	slot0:_enterVersionActivityView(ViewName.VersionActivityTaskView, VersionActivity1_6Enum.ActivityId.Act113, slot0._openTaskView, slot0)
end

function slot0._openTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function ()
		ViewMgr.instance:openView(ViewName.VersionActivityTaskView)
	end)
end

function slot0.openCachotEnterView(slot0)
	slot0:_enterVersionActivityView(ViewName.V1a6_CachotEnterView, VersionActivity1_6Enum.ActivityId.Cachot, slot0._openCachotEnterView, slot0)
end

function slot0._openCachotEnterView(slot0)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView)
end

function slot0._enterVersionActivityView(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		if slot7 then
			GameFacade.showToast(slot7, slot8)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2, slot5)

		return
	end

	ViewMgr.instance:openView(slot1, slot5)
end

function slot0.GetActivityPrefsKey(slot0)
	return VersionActivity1_6Enum.ActivityId.EnterView .. slot0
end

slot0.instance = slot0.New()

return slot0
