module("modules.common.activity.ActivityLiveMgr", package.seeall)

slot0 = class("ActivityLiveMgr")

function slot0.init(slot0)
	slot0:initActivityMgrList()
	slot0:addConstEvents()
end

function slot0.getLiveMgrVersion(slot0)
	for slot4, slot5 in ipairs(slot0.actMgrInstanceList) do
		return string.gsub(slot5.__cname, "ActivityLiveMgr", "")
	end
end

function slot0.initActivityMgrList(slot0)
	slot0.actMgrInstanceList = {
		ActivityLiveMgr2_5.instance
	}
	slot0.actId2ViewList = {}

	for slot4, slot5 in ipairs(slot0.actMgrInstanceList) do
		slot5:init()

		for slot9, slot10 in pairs(slot5:getActId2ViewList()) do
			if slot0.actId2ViewList[slot9] then
				logWarn(string.format("act : %s config multiple, please check!"))
			end

			slot0.actId2ViewList[slot9] = slot10
		end
	end
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0.checkActivity, slot0)
end

function slot0.checkActivity(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		for slot5, slot6 in pairs(slot0.actId2ViewList) do
			if slot0:checkOneActivityIsEnd(slot5) then
				return
			end
		end
	end

	slot0:checkOneActivityIsEnd(slot1)
end

function slot0.checkOneActivityIsEnd(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		return false
	end

	if ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal and slot0.actId2ViewList[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			if ViewMgr.instance:isOpen(slot8) then
				MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, uv0.yesCallback)

				return true
			end
		end
	end

	return false
end

function slot0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

slot0.instance = slot0.New()

return slot0
