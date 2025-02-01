module("modules.logic.versionactivity1_2.enter.controller.VersionActivity1_2EnterController", package.seeall)

slot0 = class("VersionActivity1_2EnterController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0._onFinishStory(slot0, slot1)
	for slot5, slot6 in ipairs(VersionActivity1_2Enum.EnterViewActIdList) do
		if ActivityHelper.getActivityStatus(slot6) == ActivityEnum.ActivityStatus.Normal then
			ActivityEnterMgr.instance:enterActivity(slot6)
		end
	end

	ActivityRpc.instance:sendActivityNewStageReadRequest(VersionActivity1_2Enum.EnterViewActIdList, function ()
		uv0:_openVersionActivity1_2EnterView(uv1 and uv1.skipOpenAnim)
	end, slot0)
end

function slot0._openVersionActivity1_2EnterView(slot0, slot1)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_2Enum.ActivityId.EnterView)

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		return
	end

	if not VersionActivityBaseController.instance:isPlayedActivityVideo(slot2) then
		if ActivityModel.instance:getActMO(slot2) and slot6.config and slot6.config.storyId and slot7 ~= 0 then
			StoryController.instance:playStory(slot7, nil, slot0._onFinishStory, slot0, {
				skipOpenAnim = slot1
			})
		else
			logWarn(string.format("act id %s dot config story id", slot7))
			slot0:_onFinishStory({
				skipOpenAnim = slot1
			})
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_2EnterView, {
		actId = slot2,
		skipOpenAnim = slot1,
		activityIdList = VersionActivity1_2Enum.EnterViewActIdList
	})

	if slot0.openedCallback then
		slot0.openedCallback(slot0.openedCallbackObj, slot0.openedCallbackParam)

		slot0.openedCallback = nil
		slot0.openedCallbackObj = nil
		slot0.openedCallbackParam = nil
	end
end

function slot0.openVersionActivity1_2EnterView(slot0, slot1, slot2, slot3)
	slot0.openedCallback = slot1
	slot0.openedCallbackObj = slot2
	slot0.openedCallbackParam = slot3

	slot0:_openVersionActivity1_2EnterView()
end

function slot0.directOpenVersionActivity1_2EnterView(slot0, slot1, slot2, slot3)
	slot0.openedCallback = slot1
	slot0.openedCallbackObj = slot2
	slot0.openedCallbackParam = slot3

	slot0:_openVersionActivity1_2EnterView(true)
end

function slot0.openActivityStoreView(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_2Enum.ActivityId.DungeonStore)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)
end

slot0.instance = slot0.New()

return slot0
