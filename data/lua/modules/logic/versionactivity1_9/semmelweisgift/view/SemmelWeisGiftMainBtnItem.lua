module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftMainBtnItem", package.seeall)

slot0 = class("SemmelWeisGiftMainBtnItem", Activity101SignViewBtnBase)

function slot0.onRefresh(slot0)
	slot0:_setMainSprite("v1a6_act_icon3")
end

function slot0.onClick(slot0)
	slot1, slot2 = slot0:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(slot1) then
		return
	end

	SemmelWeisGiftController.instance:openSemmelWeisGiftView()
end

return slot0
