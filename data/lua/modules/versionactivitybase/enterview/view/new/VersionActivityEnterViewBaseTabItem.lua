module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterViewBaseTabItem", package.seeall)

slot0 = class("VersionActivityEnterViewBaseTabItem", LuaCompBase)

function slot0.init(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	slot0.go = slot1
	slot0.rectTr = slot0.go:GetComponent(gohelper.Type_RectTransform)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)

	slot0:_editableInitView()
	gohelper.setActive(slot0.go, true)
end

function slot0.setData(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.actSetting = slot2
	slot0.redDotUid = slot2.redDotUid or 0
	slot0.storeId = slot2.storeId

	slot0:updateActId()
	slot0:afterSetData()
	TaskDispatcher.runRepeat(slot0.refreshTag, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.updateActId(slot0)
	if VersionActivityEnterHelper.getActId(slot0.actSetting) == slot0.actId then
		return false
	end

	slot0.actId = slot1
	slot0.activityCo = ActivityConfig.instance:getActivityCo(slot0.actId)

	return true
end

function slot0.setClickFunc(slot0, slot1, slot2)
	slot0.customClick = slot1
	slot0.customClickObj = slot2
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshTag, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.refreshSelect, slot0)
	slot0.click:AddClickListener(slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshTag, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.refreshSelect, slot0)
	slot0.click:RemoveClickListener()
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot0.actId ~= slot1 then
		return
	end

	slot0:refreshTag()
end

function slot0.refreshSelect(slot0, slot1)
	slot0.isSelect = slot1 == slot0.actId

	slot0:childRefreshSelect()
end

function slot0.onClick(slot0)
	if slot0.isSelect then
		return
	end

	if slot0.customClick then
		slot0.customClick(slot0.customClickObj, slot0)

		return
	end

	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot0.storeId or slot0.actId)

	if slot2 == ActivityEnum.ActivityStatus.Normal or slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		slot0.animator:Play("click", 0, 0)
		VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, slot0.actId, slot0)

		return
	end

	if slot3 then
		GameFacade.showToastWithTableParam(slot3, slot4)
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)
end

function slot0._editableInitView(slot0)
	logError("override VersionActivityEnterViewBaseTabItem:_editableInitView")
end

function slot0.afterSetData(slot0)
end

function slot0.childRefreshSelect(slot0)
	logError("override VersionActivityEnterViewBaseTabItem:childRefreshSelect")
end

function slot0.childRefreshUI(slot0)
end

function slot0.refreshTag(slot0)
end

function slot0.refreshUI(slot0)
	slot0:childRefreshUI()
	slot0:refreshTag()
end

function slot0.getAnchorY(slot0)
	return recthelper.getAnchorY(slot0.rectTr)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshTag, slot0)
end

return slot0
