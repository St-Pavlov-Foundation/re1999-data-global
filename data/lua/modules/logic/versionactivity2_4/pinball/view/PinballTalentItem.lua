module("modules.logic.versionactivity2_4.pinball.view.PinballTalentItem", package.seeall)

slot0 = class("PinballTalentItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._imageicon = gohelper.findChildImage(slot1, "#image_icon")
	slot0._imageiconbg_select = gohelper.findChildImage(slot1, "#image_iconbg_select")
	slot0._imageiconbg_unselect = gohelper.findChildImage(slot1, "#image_iconbg_unselect")
	slot0._effect = gohelper.findChild(slot1, "vx_upgrade")
	slot0._red = gohelper.findChild(slot1, "go_reddot")
end

function slot0.addEventListeners(slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshUI, slot0)
end

function slot0.setData(slot0, slot1, slot2)
	slot0._data = slot1
	slot0._buildingCo = slot2
end

function slot0.onLearn(slot0)
	gohelper.setActive(slot0._effect, false)
	gohelper.setActive(slot0._effect, true)
end

function slot0._refreshUI(slot0)
	slot0:setSelect(false)
end

function slot0.setSelect(slot0, slot1)
	slot3 = slot0:canActive2()
	slot5 = ""

	if slot1 and slot0:isActive() and slot0._data.isBig then
		slot5 = "v2a4_tutushizi_talenbg1_1"
	elseif slot1 and not slot2 and slot3 and slot4 then
		slot5 = "v2a4_tutushizi_talenbg1_2"
	elseif slot1 and not slot2 and not slot3 and slot4 then
		slot5 = "v2a4_tutushizi_talenbg1_0"
	elseif not slot1 and slot2 and slot4 then
		slot5 = "v2a4_tutushizi_talenbg1_3"
	elseif not slot1 and not slot2 and slot3 and slot4 then
		slot5 = "v2a4_tutushizi_talenbg1_4"
	elseif not slot1 and not slot2 and not slot3 and slot4 then
		slot5 = "v2a4_tutushizi_talenbg1_5"
	elseif slot1 and slot2 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_1"
	elseif slot1 and not slot2 and slot3 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_2"
	elseif slot1 and not slot2 and not slot3 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_0"
	elseif not slot1 and slot2 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_3"
	elseif not slot1 and not slot2 and slot3 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_4"
	elseif not slot1 and not slot2 and not slot3 and not slot4 then
		slot5 = "v2a4_tutushizi_talenbg2_5"
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, slot0._data.icon)
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageiconbg_select, slot5)
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageiconbg_unselect, slot5)
	gohelper.setActive(slot0._imageiconbg_select, slot1)
	gohelper.setActive(slot0._imageiconbg_unselect, not slot1)
	gohelper.setActive(slot0._red, slot3)
end

function slot0.isActive(slot0)
	if not slot0._data then
		return false
	end

	return PinballModel.instance:getTalentMo(slot0._data.id) and true or false
end

function slot0.canActive(slot0)
	for slot5, slot6 in pairs(string.splitToNumber(slot0._data.condition, "#") or {}) do
		if not PinballModel.instance:getTalentMo(slot6) then
			return false
		end
	end

	if PinballModel.instance:getBuildingInfoById(slot0._buildingCo.id) and slot4.level < slot0._data.needLv then
		return false
	end

	return true
end

function slot0.canActive2(slot0)
	if slot0:isActive() then
		return false
	end

	if not slot0:canActive() then
		return false
	end

	if not string.nilorempty(slot0._data.cost) then
		for slot6, slot7 in pairs(GameUtil.splitString2(slot1, true)) do
			if PinballModel.instance:getResNum(slot7[1]) < slot7[2] then
				return false
			end
		end
	end

	return true
end

return slot0
