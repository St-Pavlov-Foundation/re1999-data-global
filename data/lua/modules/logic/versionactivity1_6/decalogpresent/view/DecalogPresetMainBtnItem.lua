module("modules.logic.versionactivity1_6.decalogpresent.view.DecalogPresetMainBtnItem", package.seeall)

slot0 = class("DecalogPresetMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.findChildClickWithAudio(slot0.go, "bg", AudioEnum.ui_activity.play_ui_activity_open)
	slot0._redDotParent = gohelper.findChild(slot0.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "v1a6_act_icon1")

	if not ActivityType101Model.instance:isInit(DecalogPresentModel.instance:getDecalogPresentActId()) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot2)
	end

	slot0.redDot = RedDotController.instance:addNotEventRedDot(slot0._redDotParent, DecalogPresentModel.isShowRedDot, DecalogPresentModel.instance)

	gohelper.setActive(slot0.go, true)
end

function slot0.addEventListeners(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshRedDot, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnitem:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshRedDot, slot0)
end

function slot0._onItemClick(slot0)
	DecalogPresentController.instance:openDecalogPresentView()
end

function slot0.refreshRedDot(slot0)
	if not gohelper.isNil(slot0.redDot.gameObject) then
		return
	end

	slot0.redDot:refreshRedDot()
end

function slot0.isShowRedDot(slot0)
	return slot0.redDot and slot0.redDot.isShowRedDot
end

function slot0.destroy(slot0)
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
	slot0.go = nil
	slot0._imgitem = nil
	slot0._btnitem = nil
	slot0.redDot = nil
end

return slot0
