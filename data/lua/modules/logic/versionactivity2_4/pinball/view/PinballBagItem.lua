module("modules.logic.versionactivity2_4.pinball.view.PinballBagItem", package.seeall)

slot0 = class("PinballBagItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._click = gohelper.findChildClickWithDefaultAudio(slot1, "")
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot0._imageicon = gohelper.findChildImage(slot1, "#image_icon")
	slot0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot1)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnLongPress:RemoveLongPressListener()
end

function slot0._onClick(slot0)
	if slot0._curNum <= 0 then
		return
	end

	if slot0._canPlaceNum <= 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickBagItem, slot0._resType)
end

function slot0._onLongClickItem(slot0)
	slot1 = slot0._imageicon.transform
	slot3 = slot1.position
	slot3.x = slot3.x + recthelper.getWidth(slot1) / 2 * slot1.lossyScale.x

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		isMarbals = true,
		arrow = "TR",
		type = slot0._resType,
		pos = slot3
	})
end

function slot0.setInfo(slot0, slot1, slot2, slot3)
	slot0._resType = slot1 or slot0._resType
	slot0._curNum = slot2 or slot0._curNum
	slot0._canPlaceNum = slot3

	if slot0._resType > 0 then
		slot5 = slot2 > 0 and slot3 > 0 and 1 or 0.5

		UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0._resType].icon, true, slot5)
		ZProj.UGUIHelper.SetColorAlpha(slot0._imageicon, slot5)
	end

	slot0._txtNum.text = slot0._curNum
end

return slot0
