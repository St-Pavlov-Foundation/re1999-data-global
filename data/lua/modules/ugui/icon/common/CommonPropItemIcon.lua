module("modules.ugui.icon.common.CommonPropItemIcon", package.seeall)

slot0 = class("CommonPropItemIcon", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.go = slot0.viewGO
	slot0._goitem = gohelper.findChild(slot0.viewGO, "go_item")
	slot0._goequip = gohelper.findChild(slot0.viewGO, "go_equip")
	slot0._gogold = gohelper.findChild(slot0.viewGO, "#go_gold")
	slot0._nameTxt = gohelper.findChildText(slot0.viewGO, "txt")
	slot0._rareInGos = slot0:getUserDataTb_()
	slot0._hightQualityEffect = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._rareInGos, gohelper.findChild(slot0.viewGO, "vx/" .. tostring(slot4)))
	end

	for slot4 = 4, 5 do
		table.insert(slot0._hightQualityEffect, slot4, gohelper.findChild(slot0.viewGO, "vx/" .. tostring(slot4) .. "/#teshudaoju"))
	end

	gohelper.setActive(slot0._nameTxt.gameObject, false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setMOValue(slot1.materilType, slot1.materilId, slot1.quantity, slot1.uid, slot1.isIcon, slot1.isGold, slot1.roomBuildingLevel)
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0._type = tonumber(slot1)

	if slot0._type == MaterialEnum.MaterialType.Equip then
		if not slot0._equipIcon then
			slot0._equipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 1)

			slot0._equipIcon:addClick()
		end

		slot0._equipIcon:setMOValue(slot1, slot2, slot3, slot4)
	else
		slot0._itemIcon = slot0._itemIcon or IconMgr.instance:getCommonItemIcon(slot0._goitem)

		if slot0._itemIcon and slot0._itemIcon.setQuantityColor then
			slot0._itemIcon:setQuantityColor(slot0._quantityColor)
		end

		slot0._itemIcon:setMOValue(slot1, slot2, slot3, slot4, slot5)

		slot8 = nil

		if slot1 == MaterialEnum.MaterialType.Building and slot7 and slot7 > 0 then
			slot8 = RoomConfig.instance:getLevelGroupConfig(slot2, slot7) and ResUrl.getRoomBuildingPropIcon(slot9.icon)
		end

		slot0._itemIcon:setSpecificIcon(slot8)
		slot0._itemIcon:setRoomBuildingLevel(slot7)
	end

	gohelper.setActive(slot0._goequip, slot0._type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(slot0._goitem, slot0._type ~= MaterialEnum.MaterialType.Equip)
	gohelper.setActive(slot0._gogold, slot6)

	slot0._isEquip = slot0._type == MaterialEnum.MaterialType.Equip
end

function slot0.setAlpha(slot0, slot1, slot2)
	if slot0._equipIcon then
		slot0._equipIcon:setAlpha(slot1, slot2)
	end

	if slot0._itemIcon then
		slot0._itemIcon:setAlpha(slot1, slot2)
	end
end

function slot0.hideEffect(slot0)
	for slot4, slot5 in pairs(slot0._rareInGos) do
		gohelper.setActive(slot5, false)
	end
end

function slot0.showVxEffect(slot0, slot1, slot2)
	slot1 = tonumber(slot1)
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot1, slot2)

	if slot1 == MaterialEnum.MaterialType.PlayerCloth then
		slot5 = slot3.rare or 5
	end

	for slot9, slot10 in pairs(slot0._rareInGos) do
		gohelper.setActive(slot10, false)
		gohelper.setActive(slot10, slot9 == slot5)
	end
end

function slot0.showHighQualityEffect(slot0, slot1, slot2, slot3)
	if tonumber(slot1) == MaterialEnum.MaterialType.PlayerCloth then
		slot3 = slot3 or 5
	end

	for slot8, slot9 in pairs(slot0._hightQualityEffect) do
		if slot8 == slot3 and ItemModel.canShowVfx(slot1, slot2, slot3) then
			gohelper.setActive(slot9, false)
			gohelper.setActive(slot9, true)
		else
			gohelper.setActive(slot9, false)
		end
	end
end

function slot0.setItemIconScale(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setItemIconScale(slot1)
	end

	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setItemIconScale(slot1)
	end
end

function slot0.setItemOffset(slot0, slot1, slot2)
	if slot0._itemIcon then
		slot0._itemIcon:setItemOffset(slot1, slot2)
	end

	if slot0._equipIcon then
		slot0._equipIcon:setItemOffset(slot1, slot2)
	end
end

function slot0.setCountTxtSize(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setCountFontSize(slot1)
	end

	if slot0._equipIcon then
		slot0._equipIcon:setCountFontSize(slot1)
	end
end

function slot0.setScale(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setScale(slot1)
	end

	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setScale(slot1)
	end
end

function slot0.setPropItemScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.viewGO.transform, slot1, slot1, slot1)
end

function slot0.showName(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:showName(slot1)
	end
end

function slot0.setNameType(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setNameType(slot1)
	end
end

function slot0.customOnClickCallback(slot0, slot1, slot2)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:customClick(slot1, slot2)
	end

	if slot0._itemIcon then
		slot0._itemIcon:customOnClickCallback(slot1, slot2)
	end
end

function slot0.setOnBeforeClickCallback(slot0, slot1, slot2, slot3)
	if slot0._itemIcon then
		slot0._itemIcon:setOnBeforeClickCallback(slot1, slot2, slot3)
	end
end

function slot0.showStackableNum(slot0)
	if slot0._itemIcon and slot0._itemIcon.showStackableNum then
		slot0._itemIcon:showStackableNum()
	end
end

function slot0.setFrameMaskable(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon._setFrameMaskable then
		slot0._itemIcon:_setFrameMaskable(slot1)
	end
end

function slot0.isShowCount(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowCount then
		slot0._itemIcon:isShowCount(slot1)
	end
end

function slot0.isShowQuality(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowQuality then
		slot0._itemIcon:isShowQuality(slot1)
	end

	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:isShowQuality(slot1)
	end
end

function slot0.isShowEquipAndItemCount(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowCount then
		slot0._itemIcon:isShowCount(slot1)
	end

	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:isShowCount(slot1)
	end
end

function slot0.setHideLvAndBreakFlag(slot0, slot1)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setHideLvAndBreakFlag(slot1)
	end
end

function slot0.setShowCountFlag(slot0, slot1)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setShowCountFlag(slot1)
	end
end

function slot0.isShowName(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowName then
		slot0._itemIcon:isShowName(slot1)
	end
end

function slot0.isShowEffect(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowEffect then
		slot0._itemIcon:isShowEffect(slot1)
	end
end

function slot0.isShowAddition(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.isShowAddition then
		slot0._itemIcon:isShowAddition(slot1)
	elseif slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:isShowAddition(slot1)
	end
end

function slot0.ShowEquipCount(slot0, slot1, slot2)
	if slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:showEquipCount(slot1, slot2)
	end
end

function slot0.isShowEquipCount(slot0, slot1)
	if slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:isShowCount(slot1)
	end
end

function slot0.hideExpEquipState(slot0)
	if slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:hideExpEquipState()
	end
end

function slot0.hideEquipLvAndBreak(slot0, slot1)
	if slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:hideLvAndBreak(slot1)
	end
end

function slot0.showEquipRefineContainer(slot0, slot1)
	if slot0._isEquip and slot0._equipIcon then
		slot0._equipIcon:showEquipRefineContainer(slot1)
	end
end

function slot0.setCantJump(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.setCantJump then
		slot0._itemIcon:setCantJump(slot1)
	end

	if slot0._equipIcon and slot0._equipIcon.setCantJump then
		slot0._equipIcon:setCantJump(slot1)
	end
end

function slot0.setRecordFarmItem(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon.setRecordFarmItem then
		slot0._itemIcon:setRecordFarmItem(slot1)
	end
end

function slot0.setQuantityColor(slot0, slot1)
	slot0._quantityColor = slot1

	if slot0._itemIcon and slot0._itemIcon.setQuantityColor then
		slot0._itemIcon:setQuantityColor(slot1)
	end
end

function slot0.setItemColor(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setItemColor(slot1)
	end

	if slot0._equipIcon then
		slot0._equipIcon:setItemColor(slot1)
	end
end

function slot0.showStackableNum2(slot0, slot1, slot2)
	if slot0._itemIcon and slot0._itemIcon.showStackableNum2 then
		slot0._itemIcon:showStackableNum2(slot1, slot2)
	end
end

function slot0.setCountText(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setCountText(slot1)
	end
end

function slot0.getItemIcon(slot0)
	return slot0._isEquip and slot0._equipIcon or slot0._itemIcon
end

function slot0.isEquipIcon(slot0)
	return slot0._isEquip
end

function slot0.setCountFontSize(slot0, slot1)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setCountFontSize(slot1)
	else
		slot0._itemIcon:setCountFontSize(slot1)
	end
end

function slot0.setEquipLevelScaleAndColor(slot0, slot1, slot2)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setLevelScaleAndColor(slot1, slot2)
	end
end

function slot0.setCarrerIconAndRefineVisible(slot0, slot1)
	if slot0._equipIcon and slot0._isEquip then
		slot0._equipIcon:setCarrerIconAndRefineVisible(slot1)
	end
end

function slot0.playAnimation(slot0)
	if slot0._itemIcon then
		slot0._itemIcon:playAnimation()
	end
end

function slot0.setAutoPlay(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setAutoPlay(slot1)
	end
end

function slot0.setConsume(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setConsume(slot1)
	end
end

function slot0.isShowEquipRefineLv(slot0, slot1)
	if slot0._isEquip then
		slot0._equipIcon:isShowRefineLv(slot1)
	end
end

function slot0.SetCountLocalY(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon._txtQuantity then
		recthelper.setAnchorY(slot0._itemIcon._txtQuantity.transform, slot1)
	end

	if slot0._equipIcon and slot0._equipIcon._txtnum then
		recthelper.setAnchorY(slot0._equipIcon._txtnum.transform, slot1 - 39.6)
	end
end

function slot0.SetCountBgHeight(slot0, slot1)
	if slot0._itemIcon and slot0._itemIcon._countbg then
		recthelper.setHeight(slot0._itemIcon._countbg.transform, slot1)
	end

	if slot0._equipIcon and slot0._equipIcon._countbg then
		recthelper.setHeight(slot0._equipIcon._countbg.transform, slot1)
	end
end

function slot0.SetCountBgScale(slot0, slot1, slot2, slot3)
	if slot0._itemIcon and slot0._itemIcon._countbg then
		transformhelper.setLocalScale(slot0._itemIcon._countbg.transform, slot1, slot2, slot3)
	end

	if slot0._equipIcon and slot0._equipIcon._countbg then
		transformhelper.setLocalScale(slot0._equipIcon._countbg.transform, slot1, slot2, slot3)
	end
end

function slot0.setGetMask(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setGetMask(slot1)
	end

	if slot0._equipIcon then
		slot0._equipIcon:setGetMask(slot1)
	end
end

function slot0.setIconBg(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setIconBg(slot1)
	end
end

function slot0.setCanShowDeadLine(slot0, slot1)
	if slot0._itemIcon then
		slot0._itemIcon:setCanShowDeadLine(slot1)
	end
end

function slot0.isExpiredItem(slot0)
	if slot0._itemIcon then
		return slot0._itemIcon:isExpiredItem()
	end

	if slot0._equipIcon then
		return slot0._equipIcon:isExpiredItem()
	end
end

return slot0
