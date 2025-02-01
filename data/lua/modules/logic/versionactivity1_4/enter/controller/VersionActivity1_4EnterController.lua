module("modules.logic.versionactivity1_4.enter.controller.VersionActivity1_4EnterController", package.seeall)

slot0 = class("VersionActivity1_4EnterController", BaseController)

function slot0.onInit(slot0)
	slot0.actId = VersionActivity1_4Enum.ActivityId.EnterView
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_4EnterView) then
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

	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, slot0.actId, slot0._openVersionActivityEnterView, slot0)
end

function slot0._onFinishStory(slot0)
	if ActivityHelper.getActivityStatus(slot0.actId) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0:_openVersionActivityEnterView()
end

function slot0._openVersionActivityEnterView(slot0)
	if ActivityConfig.instance:getActivityCo(slot0.actId) and slot1.storyId and slot2 > 0 and not StoryModel.instance:isStoryFinished(slot1.storyId) then
		StoryController.instance:playStory(slot2, {
			isVersionActivityPV = true
		}, slot0._onFinishStory, slot0)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
		actId = slot0.actId,
		activityIdList = VersionActivity1_4Enum.EnterViewActIdList
	})

	if slot0.openedCallback then
		slot0.openedCallback(slot0.openedCallbackObj)

		slot0.openedCallback = nil
		slot0.openedCallbackObj = nil
	end
end

function slot0.directOpenVersionActivityEnterView(slot0)
	VersionActivityBaseController.instance:enterVersionActivityView(ViewName.VersionActivity1_4EnterView, slot0.actId, function ()
		ViewMgr.instance:openView(ViewName.VersionActivity1_4EnterView, {
			skipOpenAnim = true,
			actId = uv0.actId,
			activityIdList = VersionActivity1_4Enum.EnterViewActIdList
		})
	end, slot0)
end

slot0.instance = slot0.New()

return slot0
