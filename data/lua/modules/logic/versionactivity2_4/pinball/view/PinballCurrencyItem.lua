module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem", package.seeall)

slot0 = class("PinballCurrencyItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "content/#txt")
	slot0._imageicon = gohelper.findChildImage(slot1, "#image")
	slot0._btn = gohelper.findButtonWithAudio(slot1)
	slot0._anim = gohelper.findChildAnim(slot1, "")
end

function slot0.addEventListeners(slot0)
	slot0._btn:AddClickListener(slot0._openTips, slot0)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, slot0._refreshUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btn:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, slot0._refreshUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, slot0._refreshUI, slot0)
end

function slot0.setCurrencyType(slot0, slot1)
	slot0._currencyType = slot1

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = PinballModel.instance:getResNum(slot0._currencyType)

	if slot0._cacheNum and slot0._cacheNum < slot1 then
		slot0._anim:Play("refresh", 0, 0)
	end

	slot0._cacheNum = slot1
	slot0._txtNum.text = GameUtil.numberDisplay(slot1)

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0._currencyType] then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, slot2.icon)
end

function slot0._openTips(slot0)
	slot1 = slot0._imageicon.transform
	slot2 = slot1.lossyScale
	slot3 = slot1.position
	slot3.x = slot3.x + recthelper.getWidth(slot1) / 2 * slot2.x
	slot3.y = slot3.y - recthelper.getHeight(slot1) / 2 * slot2.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "BL",
		type = slot0._currencyType,
		pos = slot3
	})
end

return slot0
