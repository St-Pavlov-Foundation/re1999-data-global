module("modules.logic.versionactivity.controller.VersionActivityController", package.seeall)

slot0 = class("VersionActivityController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivityEnterView) then
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

	slot0:_enterVersionActivityView(ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, slot0._openVersionActivityEnterView, slot0)
end

function slot0._onFinishStory(slot0)
	if ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act105) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	for slot5, slot6 in ipairs(VersionActivityEnum.EnterViewActIdList) do
		if ActivityHelper.getActivityStatus(slot6) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(slot6)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivityEnum.EnterViewActIdList, function ()
		uv0:_openVersionActivityEnterView()
	end, slot0)
end

function slot0._openVersionActivityEnterView(slot0)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivityEnum.ActivityId.Act105) then
		if not (ActivityModel.instance:getActMO(VersionActivityEnum.ActivityId.Act105) and slot1.config and slot1.config.storyId) then
			logError(string.format("act id %s dot config story id", slot2))

			slot2 = 100010
		end

		StoryController.instance:playStory(slot2, {
			isVersionActivityPV = true
		}, slot0._onFinishStory, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
		actId = VersionActivityEnum.ActivityId.Act105,
		activityIdList = VersionActivityEnum.EnterViewActIdList
	})

	if slot0.openedCallback then
		slot0.openedCallback(slot0.openedCallbackObj)

		slot0.openedCallback = nil
		slot0.openedCallbackObj = nil
	end
end

function slot0.directOpenVersionActivityEnterView(slot0)
	slot0:_enterVersionActivityView(ViewName.VersionActivityEnterView, VersionActivityEnum.ActivityId.Act105, function ()
		ViewMgr.instance:openView(ViewName.VersionActivityEnterView, {
			skipOpenAnim = true,
			actId = VersionActivityEnum.ActivityId.Act105,
			activityIdList = VersionActivityEnum.EnterViewActIdList
		})
	end, slot0)
end

function slot0.openLeiMiTeBeiStoreView(slot0, slot1)
	if ReactivityModel.instance:isReactivity(slot1) then
		ReactivityController.instance:openReactivityStoreView(slot1)

		return
	end

	slot0:_enterVersionActivityView(ViewName.VersionActivityStoreView, VersionActivityEnum.ActivityId.Act107, slot0._openStoreView, slot0)
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

function slot0.openLeiMiTeBeiTaskView(slot0)
	if ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113) then
		ReactivityController.instance:openReactivityTaskView(slot1)

		return
	end

	slot0:_enterVersionActivityView(ViewName.VersionActivityTaskView, slot1, slot0._openLeiMiTeBeiTaskView, slot0)
end

function slot0._openLeiMiTeBeiTaskView(slot0)
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
			GameFacade.showToastWithTableParam(slot6, slot7)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2)

		return
	end

	ViewMgr.instance:openView(slot1)
end

slot0.instance = slot0.New()

return slot0
