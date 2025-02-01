module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentMainBtnItem", package.seeall)

slot0 = class("GoldenMilletPresentMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.findChildClickWithAudio(slot0.go, "bg", AudioEnum.UI.GoldenMilletMainBtnClick)
	slot0._redDotParent = gohelper.findChild(slot0.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "v1a6_act_icon4")

	if not ActivityType101Model.instance:isInit(GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot2)
	end

	slot0.redDot = RedDotController.instance:addNotEventRedDot(slot0._redDotParent, GoldenMilletPresentModel.isShowRedDot, GoldenMilletPresentModel.instance)

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
	GoldenMilletPresentController.instance:openGoldenMilletPresentView()
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
