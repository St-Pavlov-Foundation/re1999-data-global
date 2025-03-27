module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem2", package.seeall)

slot0 = class("PinballCurrencyItem2", PinballCurrencyItem)

function slot0.init(slot0, slot1)
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot0._imageicon = gohelper.findChildImage(slot1, "#image_icon")
	slot0._btn = gohelper.findButtonWithAudio(slot1)
	slot0._anim = gohelper.findChildAnim(slot1, "")
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, slot0._refreshUI, slot0)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, slot0._refreshUI, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, slot0._refreshUI, slot0)
end

function slot0._refreshUI(slot0)
	slot1 = PinballModel.instance:getResNum(slot0._currencyType)
	slot2 = math.max(slot0._currencyType == PinballEnum.ResType.Food and PinballModel.instance:getTotalFoodCost() or slot0._currencyType == PinballEnum.ResType.Play and PinballModel.instance:getTotalPlayDemand() or 0, 0)

	if slot0._cacheNum and (slot0._cacheNum ~= slot1 or slot0._cacheMaxNum ~= slot2) then
		slot0._anim:Play("refresh", 0, 0)
	end

	slot0._cacheNum = slot1
	slot0._cacheMaxNum = slot2

	if slot2 <= slot1 then
		slot0._txtNum.text = GameUtil.numberDisplay(slot1) .. "/" .. GameUtil.numberDisplay(slot2)
	else
		slot0._txtNum.text = "<color=#9F342C>" .. GameUtil.numberDisplay(slot1) .. "</color>/" .. GameUtil.numberDisplay(slot2)
	end

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0._currencyType] then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, slot3.icon)
end

function slot0._openTips(slot0)
	slot1 = slot0._imageicon.transform
	slot2 = slot1.lossyScale
	slot3 = slot1.position
	slot3.x = slot3.x - recthelper.getWidth(slot1) / 2 * slot2.x
	slot3.y = slot3.y + recthelper.getHeight(slot1) / 2 * slot2.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "TR",
		type = slot0._currencyType,
		pos = slot3
	})
end

return slot0
