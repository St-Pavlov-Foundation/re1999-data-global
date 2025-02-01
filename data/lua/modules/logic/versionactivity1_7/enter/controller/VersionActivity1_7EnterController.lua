module("modules.logic.versionactivity1_7.enter.controller.VersionActivity1_7EnterController", package.seeall)

slot0 = class("VersionActivity1_7EnterController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2, slot3)
	if ViewMgr.instance:isOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	slot0:openVersionActivityEnterView(slot1, slot2, slot3)
end

function slot0.openVersionActivityEnterView(slot0, slot1, slot2, slot3)
	if not slot0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	slot0:_openVersionActivityEnterView(slot1, slot2, slot3)
end

function slot0._onFinishStory(slot0)
	if not slot0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	slot0:_openVersionActivityEnterView(slot0.openCallback, slot0.openedCallbackObj, slot0.jumpActId)
end

function slot0._openVersionActivityEnterView(slot0, slot1, slot2, slot3)
	if not VersionActivityBaseController.instance:isPlayedActivityVideo(VersionActivity1_7Enum.ActivityId.EnterView) then
		if not (ActivityModel.instance:getActMO(VersionActivity1_7Enum.ActivityId.EnterView) and slot4.config and slot4.config.storyId) then
			logError(string.format("act id %s dot config story id", slot5))

			slot5 = 100010
		end

		slot0.openCallback = slot1
		slot0.openedCallbackObj = slot2
		slot0.jumpActId = slot3

		StoryController.instance:playStory(slot5, {
			isVersionActivityPV = true
		}, slot0._onFinishStory, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = slot3
	})

	if slot1 then
		slot1(slot2)
	end
end

function slot0.directOpenVersionActivityEnterView(slot0, slot1)
	if not slot0:checkCanOpen(VersionActivity1_7Enum.ActivityId.EnterView) then
		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_7EnterView, {
		skipOpenAnim = true,
		actId = VersionActivity1_7Enum.ActivityId.EnterView,
		activityIdList = VersionActivity1_7Enum.EnterViewActIdList,
		jumpActId = slot1
	})
end

function slot0.checkCanOpen(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot1)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		if slot3 then
			GameFacade.showToast(slot3, slot4)
		end

		return false
	end

	return true
end

function slot0.GetActivityPrefsKey(slot0)
	return VersionActivity1_7Enum.ActivityId.EnterView .. slot0
end

function slot0.GetActivityPrefsKeyWithUser(slot0)
	return PlayerModel.instance:getPlayerPrefsKey(uv0.GetActivityPrefsKey(slot0))
end

slot0.instance = slot0.New()

return slot0
