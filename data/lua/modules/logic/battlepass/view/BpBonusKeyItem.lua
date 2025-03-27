module("modules.logic.battlepass.view.BpBonusKeyItem", package.seeall)

slot0 = class("BpBonusKeyItem", LuaCompBase)

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
	slot0._payHasGet2 = gohelper.findChild(slot0.go, "pay/#goHasGet/get2")

	gohelper.setActive(slot0._freeItemGO, false)
	gohelper.setActive(slot0._payItemGO, false)

	slot0._freeBonusList = {}
	slot0._payBonusList = {}
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._txtLevel.text = luaLang("level") .. slot1.level
	slot4 = slot0.mo.level <= math.floor(BpModel.instance.score / BpConfig.instance:getLevelScore(BpModel.instance.id))
	slot5 = slot0.mo.level <= slot3
	slot6 = slot0.mo.level <= slot3 and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	slot9 = BpConfig.instance:getBonusCO(BpModel.instance.id, slot0.mo.level)

	slot0:_setBonus(GameUtil.splitString2(slot9.freeBonus, true), slot0._freeBonusList, slot0._freeItemGO, slot0._onFreeItemIconClick, slot4, slot0.mo.hasGetfreeBonus)
	slot0:_setBonus(GameUtil.splitString2(slot9.payBonus, true), slot0._payBonusList, slot0._payItemGO, slot0._onPayItemIconClick, slot4, slot0.mo.hasGetPayBonus)
	gohelper.setActive(slot0._freeHasGet, slot5 and slot7)
	gohelper.setActive(slot0._payHasGet, slot6 and slot8)
	gohelper.setActive(slot0.freelock, not slot5)
	gohelper.setActive(slot0.paylock, not slot6)
	gohelper.setActive(slot0.paylock2, not slot6 and #slot11 == 2)
	gohelper.setActive(slot0._payHasGet2, #slot11 == 2)
end

function slot0._setBonus(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	for slot10, slot11 in ipairs(slot1) do
		if not slot2[slot10] then
			slot13 = gohelper.cloneInPlace(slot3)

			gohelper.setActive(slot13, true)
			table.insert(slot2, IconMgr.instance:getCommonPropItemIcon(slot13))
		end

		gohelper.setAsFirstSibling(slot12.go)
		slot12:setMOValue(slot11[1], slot11[2], slot11[3], nil, true)

		if slot11[1] == MaterialEnum.MaterialType.Equip then
			slot12._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, slot12._equipIcon)
			slot12._equipIcon:_loadIconImage()
		end

		slot12:setCountFontSize(46)
		slot12:setScale(0.6)

		slot13, slot14, slot15 = BpConfig.instance:getItemShowSize(slot11[1], slot11[2])

		slot12:setItemIconScale(slot13)
		slot12:setItemOffset(slot14, slot15)
		slot12:SetCountLocalY(43.6)
		slot12:SetCountBgHeight(40)
		slot12:SetCountBgScale(1, 1.3, 1)
		slot12:showStackableNum()
		slot12:setHideLvAndBreakFlag(true)
		slot12:hideEquipLvAndBreak(true)
		slot12:isShowCount(true)

		if slot6 then
			slot12:setAlpha(0.45, 0.8)
		else
			slot12:setAlpha(1, 1)
		end

		slot12:isShowCount(slot11[1] ~= MaterialEnum.MaterialType.Hero)
		gohelper.setActive(slot12.go.transform.parent.gameObject, true)
	end

	for slot10 = #slot1 + 1, #slot2 do
		gohelper.setActive(slot2[slot10].go.transform.parent.gameObject, false)
	end
end

function slot0._onFreeItemIconClick(slot0)
end

function slot0._onPayItemIconClick(slot0)
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
