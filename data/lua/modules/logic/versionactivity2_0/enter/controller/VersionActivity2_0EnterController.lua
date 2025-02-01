module("modules.logic.versionactivity2_0.enter.controller.VersionActivity2_0EnterController", package.seeall)

slot0 = class("VersionActivity2_0EnterController", BaseController)

function slot0._internalOpenView(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not VersionActivityEnterHelper.checkCanOpen(slot2) then
		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2, slot5)
	else
		ViewMgr.instance:openView(slot1, slot5)

		if slot6 then
			slot6(slot7)
		end
	end
end

function slot0._internalOpenEnterView(slot0, slot1, slot2, slot3)
	if VersionActivityBaseController.instance:isPlayedActivityVideo(slot2) then
		ViewMgr.instance:openView(slot1, slot3)

		if slot0.openEnterViewCb then
			slot0.openEnterViewCb(slot0.openEnterViewCbObj)

			slot0.openEnterViewCb = nil
			slot0.openEnterViewCbObj = nil
		end
	else
		if not (ActivityModel.instance:getActMO(slot2) and slot5.config and slot5.config.storyId) then
			logError(string.format("act id %s dot config story id", 100010))
		end

		StoryController.instance:playStory(slot6, {
			isVersionActivityPV = true
		}, slot0._onFinishEnterStory, slot0, {
			actId = slot2,
			viewName = slot1,
			viewParams = slot3
		})
	end
end

function slot0._onFinishEnterStory(slot0, slot1)
	if not VersionActivityEnterHelper.checkCanOpen(slot1.actId) then
		return
	end

	slot0:_internalOpenEnterView(slot1.viewName, slot2, slot1.viewParams)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0, slot1, slot2, slot3, slot4)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0EnterView) then
		if slot1 then
			slot1(slot2)
		end
	else
		slot0:openVersionActivityEnterView(slot1, slot2, slot3, slot4)
	end
end

function slot0.directOpenVersionActivityEnterView(slot0, slot1)
	slot0:openVersionActivityEnterView(nil, , slot1, true)
end

function slot0.openVersionActivityEnterView(slot0, slot1, slot2, slot3, slot4)
	slot0.openEnterViewCb = slot1
	slot0.openEnterViewCbObj = slot2
	slot8 = nil

	if slot4 then
		-- Nothing
	else
		slot8 = slot0._internalOpenEnterView
	end

	slot0:_internalOpenView(ViewName.VersionActivity2_0EnterView, slot5, slot8, slot0, {
		actId = VersionActivity2_0Enum.ActivityId.EnterView,
		jumpActId = slot3,
		activityIdList = VersionActivityEnterHelper.getActIdList(VersionActivity2_0Enum.EnterViewActSetting),
		activitySettingList = VersionActivity2_0Enum.EnterViewActSetting,
		isDirectOpen = true
	}, slot0.openEnterViewCb, slot0.openEnterViewCbObj)
end

slot0.instance = slot0.New()

return slot0
