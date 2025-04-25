module("modules.logic.versionactivity1_4.act136.view.Activity136MainBtnItem", package.seeall)

slot0 = class("Activity136MainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.findChildClick(slot0.go, "bg")
	slot0._redDotParent = gohelper.findChild(slot0.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, ActivityModel.showActivityEffect() and ActivityConfig.instance:getMainActAtmosphereConfig().mainViewActBtnPrefix .. "icon_5" or "icon_5", true)

	if not slot2 and ActivityConfig.instance:getMainActAtmosphereConfig() then
		for slot9, slot10 in ipairs(slot5.mainViewActBtn) do
			if gohelper.findChild(slot0.go, slot10) then
				gohelper.setActive(slot11, slot2)
			end
		end
	end

	slot0.redDot = RedDotController.instance:addNotEventRedDot(slot0._redDotParent, Activity136Model.isShowRedDot, Activity136Model.instance)

	gohelper.setActive(slot0.go, true)
end

function slot0.addEventListeners(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, slot0.refreshRedDot, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnitem:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, slot0.refreshRedDot, slot0)
end

function slot0._onItemClick(slot0)
	Activity136Controller.instance:openActivity136View()
end

function slot0.refreshRedDot(slot0)
	if not slot0.redDot then
		return
	end

	slot0.redDot:refreshRedDot()
end

function slot0.destroy(slot0)
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)

	slot0.go = nil
	slot0._imgitem = nil
	slot0._btnitem = nil
	slot0.redDot = nil
end

return slot0
