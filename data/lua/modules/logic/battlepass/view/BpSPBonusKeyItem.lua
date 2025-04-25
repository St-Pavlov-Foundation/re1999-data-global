module("modules.logic.battlepass.view.BpSPBonusKeyItem", package.seeall)

slot0 = class("BpSPBonusKeyItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtLevel = gohelper.findChildText(slot0.go, "#txtLevel")
	slot0._freeItemGO = gohelper.findChild(slot0.go, "free/freenode/#goItem")
	slot0._payItemGO = gohelper.findChild(slot0.go, "pay/paynode/#goItem")
	slot0._freeHasGet = gohelper.findChild(slot0.go, "free/#goHasGet")
	slot0._payHasGet = gohelper.findChild(slot0.go, "pay/#goHasGet")
	slot0.freelock = gohelper.findChild(slot0.go, "free/freelock/lock")
	slot0.paylock = gohelper.findChild(slot0.go, "pay/paylock/lock1")
	slot0.paylock2 = gohelper.findChild(slot0.go, "pay/paylock/lock2")
	slot0._payHasGet1 = gohelper.findChild(slot0.go, "pay/#goHasGet/get1")
	slot0._payHasGet2 = gohelper.findChild(slot0.go, "pay/#goHasGet/get2")
	slot0._getcanvasGroup1 = gohelper.onceAddComponent(slot0._payHasGet1, typeof(UnityEngine.CanvasGroup))
	slot0._getcanvasGroup2 = gohelper.onceAddComponent(slot0._payHasGet2, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot0._freeItemGO, false)
	gohelper.setActive(slot0._payItemGO, false)

	slot0._freeBonusList = {}
	slot0._payBonusList = {}
	slot0._selectBonusList = {}
end

function slot0.addEvents(slot0)
	slot0:addEventCb(BpController.instance, BpEvent.onSelectBonusGet, slot0._refreshSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.onSelectBonusGet, slot0._refreshSelect, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), slot0.mo.level)
	slot4 = slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))
	slot5 = slot0.mo.level <= slot3
	slot10 = BpConfig.instance:getBonusCO(BpModel.instance.id, slot0.mo.level)
	slot13 = GameUtil.splitString2(slot10.selfSelectPayItem, true) or {}

	slot0:_setBonus(GameUtil.splitString2(slot10.spFreeBonus, true), slot0._freeBonusList, slot0._freeItemGO, slot0._onFreeItemIconClick, slot4, slot0.mo.hasGetSpfreeBonus)
	slot0:_setBonus(GameUtil.splitString2(slot10.spPayBonus, true), slot0._payBonusList, slot0._payItemGO, slot0._onPayItemIconClick, slot4, slot0.mo.hasGetSpPayBonus)
	slot0:_setBonus(slot13, slot0._selectBonusList, slot0._payItemGO, slot0._onselectItemIconClick, slot0.mo.level <= slot3, BpBonusModel.instance:isGetSelectBonus(slot0.mo.level), true)

	if #slot13 > 0 then
		if #slot12 > 0 then
			slot0._getcanvasGroup1.alpha = slot6 and slot8 and 1 or 0
			slot0._getcanvasGroup2.alpha = slot9 and 1 or 0
		else
			slot0._getcanvasGroup1.alpha = slot9 and 1 or 0
		end
	else
		slot0._getcanvasGroup1.alpha = 1
		slot0._getcanvasGroup2.alpha = 1
	end

	gohelper.setActive(slot0._freeHasGet, slot5 and slot7)
	gohelper.setActive(slot0._payHasGet, slot6 and slot8 or slot9)
	gohelper.setActive(slot0.freelock, not slot5)
	gohelper.setActive(slot0.paylock, not slot6)
	gohelper.setActive(slot0.paylock2, not slot6 and #slot12 + #slot13 == 2)
	gohelper.setActive(slot0._payHasGet2, #slot12 + #slot13 == 2)
end

function slot0._setBonus(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	for slot11, slot12 in ipairs(slot1) do
		if not slot2[slot11] then
			slot14 = gohelper.cloneInPlace(slot3)

			gohelper.setActive(slot14, true)
			table.insert(slot2, IconMgr.instance:getCommonPropItemIcon(slot14))
		end

		gohelper.setAsFirstSibling(slot13.go)
		slot13:setMOValue(slot12[1], slot12[2], slot12[3], nil, true)

		if slot12[1] == MaterialEnum.MaterialType.Equip then
			slot13._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, slot13._equipIcon)
			slot13._equipIcon:_loadIconImage()
		end

		slot13:setCountFontSize(46)
		slot13:setScale(0.6)

		slot14, slot15, slot16 = BpConfig.instance:getItemShowSize(slot12[1], slot12[2])

		slot13:setItemIconScale(slot14)
		slot13:setItemOffset(slot15, slot16)
		slot13:SetCountLocalY(43.6)
		slot13:SetCountBgHeight(40)
		slot13:SetCountBgScale(1, 1.3, 1)
		slot13:showStackableNum()
		slot13:setHideLvAndBreakFlag(true)
		slot13:hideEquipLvAndBreak(true)

		if slot7 then
			slot13:customOnClickCallback(slot4, slot0)
		else
			slot13:customOnClickCallback(nil, )
		end

		if slot6 then
			slot13:setAlpha(0.45, 0.8)
		else
			slot13:setAlpha(1, 1)
		end

		slot13:isShowCount(slot12[1] ~= MaterialEnum.MaterialType.HeroSkin and not slot7)
		gohelper.setActive(slot13.go.transform.parent.gameObject, true)
	end

	for slot11 = #slot1 + 1, #slot2 do
		gohelper.setActive(slot2[slot11].go.transform.parent.gameObject, false)
	end
end

function slot0._onselectItemIconClick(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function slot0._onFreeItemIconClick(slot0)
end

function slot0._onPayItemIconClick(slot0)
end

function slot0._refreshSelect(slot0, slot1)
	if slot1 ~= slot0.mo.level then
		return
	end

	slot0:onUpdateMO(slot0.mo)
end

function slot0.onDestroyView(slot0)
	if slot0._freeBonusList then
		for slot4, slot5 in pairs(slot0._freeBonusList) do
			slot5:onDestroy()
		end

		slot0._freeBonusList = nil
	end

	if slot0._payBonusList then
		for slot4, slot5 in pairs(slot0._payBonusList) do
			slot5:onDestroy()
		end

		slot0._payBonusList = nil
	end
end

return slot0
