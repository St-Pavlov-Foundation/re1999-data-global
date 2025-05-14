module("modules.ugui.icon.common.CommonPropItemIcon", package.seeall)

local var_0_0 = class("CommonPropItemIcon", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.go = arg_4_0.viewGO
	arg_4_0._goitem = gohelper.findChild(arg_4_0.viewGO, "go_item")
	arg_4_0._goequip = gohelper.findChild(arg_4_0.viewGO, "go_equip")
	arg_4_0._gogold = gohelper.findChild(arg_4_0.viewGO, "#go_gold")
	arg_4_0._nameTxt = gohelper.findChildText(arg_4_0.viewGO, "txt")
	arg_4_0._rareInGos = arg_4_0:getUserDataTb_()
	arg_4_0._hightQualityEffect = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 6 do
		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "vx/" .. tostring(iter_4_0))

		table.insert(arg_4_0._rareInGos, var_4_0)
	end

	for iter_4_1 = 4, 5 do
		local var_4_1 = gohelper.findChild(arg_4_0.viewGO, "vx/" .. tostring(iter_4_1) .. "/#teshudaoju")

		table.insert(arg_4_0._hightQualityEffect, iter_4_1, var_4_1)
	end

	gohelper.setActive(arg_4_0._nameTxt.gameObject, false)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0:setMOValue(arg_7_1.materilType, arg_7_1.materilId, arg_7_1.quantity, arg_7_1.uid, arg_7_1.isIcon, arg_7_1.isGold, arg_7_1.roomBuildingLevel)
end

function var_0_0.setMOValue(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	arg_8_0._type = tonumber(arg_8_1)

	if arg_8_0._type == MaterialEnum.MaterialType.Equip then
		if not arg_8_0._equipIcon then
			arg_8_0._equipIcon = IconMgr.instance:getCommonEquipIcon(arg_8_0._goequip, 1)

			arg_8_0._equipIcon:addClick()
		end

		arg_8_0._equipIcon:setMOValue(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	else
		arg_8_0._itemIcon = arg_8_0._itemIcon or IconMgr.instance:getCommonItemIcon(arg_8_0._goitem)

		if arg_8_0._itemIcon and arg_8_0._itemIcon.setQuantityColor then
			arg_8_0._itemIcon:setQuantityColor(arg_8_0._quantityColor)
		end

		arg_8_0._itemIcon:setMOValue(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)

		local var_8_0

		if arg_8_1 == MaterialEnum.MaterialType.Building and arg_8_7 and arg_8_7 > 0 then
			local var_8_1 = RoomConfig.instance:getLevelGroupConfig(arg_8_2, arg_8_7)

			var_8_0 = var_8_1 and ResUrl.getRoomBuildingPropIcon(var_8_1.icon)
		end

		arg_8_0._itemIcon:setSpecificIcon(var_8_0)
		arg_8_0._itemIcon:setRoomBuildingLevel(arg_8_7)
	end

	gohelper.setActive(arg_8_0._goequip, arg_8_0._type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(arg_8_0._goitem, arg_8_0._type ~= MaterialEnum.MaterialType.Equip)
	gohelper.setActive(arg_8_0._gogold, arg_8_6)

	arg_8_0._isEquip = arg_8_0._type == MaterialEnum.MaterialType.Equip
end

function var_0_0.setAlpha(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._equipIcon then
		arg_9_0._equipIcon:setAlpha(arg_9_1, arg_9_2)
	end

	if arg_9_0._itemIcon then
		arg_9_0._itemIcon:setAlpha(arg_9_1, arg_9_2)
	end
end

function var_0_0.hideEffect(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._rareInGos) do
		gohelper.setActive(iter_10_1, false)
	end
end

function var_0_0.showVxEffect(arg_11_0, arg_11_1, arg_11_2)
	arg_11_1 = tonumber(arg_11_1)

	local var_11_0, var_11_1 = ItemModel.instance:getItemConfigAndIcon(arg_11_1, arg_11_2)
	local var_11_2 = var_11_0.rare

	if arg_11_1 == MaterialEnum.MaterialType.PlayerCloth then
		var_11_2 = var_11_2 or 5
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0._rareInGos) do
		gohelper.setActive(iter_11_1, false)
		gohelper.setActive(iter_11_1, iter_11_0 == var_11_2)
	end
end

function var_0_0.showHighQualityEffect(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1 = tonumber(arg_12_1)

	if arg_12_1 == MaterialEnum.MaterialType.PlayerCloth then
		arg_12_3 = arg_12_3 or 5
	end

	local var_12_0 = ItemModel.canShowVfx(arg_12_1, arg_12_2, arg_12_3)

	for iter_12_0, iter_12_1 in pairs(arg_12_0._hightQualityEffect) do
		if iter_12_0 == arg_12_3 and var_12_0 then
			gohelper.setActive(iter_12_1, false)
			gohelper.setActive(iter_12_1, true)
		else
			gohelper.setActive(iter_12_1, false)
		end
	end
end

function var_0_0.setItemIconScale(arg_13_0, arg_13_1)
	if arg_13_0._itemIcon then
		arg_13_0._itemIcon:setItemIconScale(arg_13_1)
	end

	if arg_13_0._equipIcon and arg_13_0._isEquip then
		arg_13_0._equipIcon:setItemIconScale(arg_13_1)
	end
end

function var_0_0.setItemOffset(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._itemIcon then
		arg_14_0._itemIcon:setItemOffset(arg_14_1, arg_14_2)
	end

	if arg_14_0._equipIcon then
		arg_14_0._equipIcon:setItemOffset(arg_14_1, arg_14_2)
	end
end

function var_0_0.setCountTxtSize(arg_15_0, arg_15_1)
	if arg_15_0._itemIcon then
		arg_15_0._itemIcon:setCountFontSize(arg_15_1)
	end

	if arg_15_0._equipIcon then
		arg_15_0._equipIcon:setCountFontSize(arg_15_1)
	end
end

function var_0_0.setScale(arg_16_0, arg_16_1)
	if arg_16_0._itemIcon then
		arg_16_0._itemIcon:setScale(arg_16_1)
	end

	if arg_16_0._equipIcon and arg_16_0._isEquip then
		arg_16_0._equipIcon:setScale(arg_16_1)
	end
end

function var_0_0.setPropItemScale(arg_17_0, arg_17_1)
	transformhelper.setLocalScale(arg_17_0.viewGO.transform, arg_17_1, arg_17_1, arg_17_1)
end

function var_0_0.showName(arg_18_0, arg_18_1)
	if arg_18_0._itemIcon then
		arg_18_0._itemIcon:showName(arg_18_1)
	end
end

function var_0_0.setNameType(arg_19_0, arg_19_1)
	if arg_19_0._itemIcon then
		arg_19_0._itemIcon:setNameType(arg_19_1)
	end
end

function var_0_0.customOnClickCallback(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0._equipIcon and arg_20_0._isEquip then
		arg_20_0._equipIcon:customClick(arg_20_1, arg_20_2)
	end

	if arg_20_0._itemIcon then
		arg_20_0._itemIcon:customOnClickCallback(arg_20_1, arg_20_2)
	end
end

function var_0_0.setOnBeforeClickCallback(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0._itemIcon then
		arg_21_0._itemIcon:setOnBeforeClickCallback(arg_21_1, arg_21_2, arg_21_3)
	end
end

function var_0_0.showStackableNum(arg_22_0)
	if arg_22_0._itemIcon and arg_22_0._itemIcon.showStackableNum then
		arg_22_0._itemIcon:showStackableNum()
	end
end

function var_0_0.setFrameMaskable(arg_23_0, arg_23_1)
	if arg_23_0._itemIcon and arg_23_0._itemIcon._setFrameMaskable then
		arg_23_0._itemIcon:_setFrameMaskable(arg_23_1)
	end
end

function var_0_0.isShowCount(arg_24_0, arg_24_1)
	if arg_24_0._itemIcon and arg_24_0._itemIcon.isShowCount then
		arg_24_0._itemIcon:isShowCount(arg_24_1)
	end
end

function var_0_0.isShowQuality(arg_25_0, arg_25_1)
	if arg_25_0._itemIcon and arg_25_0._itemIcon.isShowQuality then
		arg_25_0._itemIcon:isShowQuality(arg_25_1)
	end

	if arg_25_0._equipIcon and arg_25_0._isEquip then
		arg_25_0._equipIcon:isShowQuality(arg_25_1)
	end
end

function var_0_0.isShowEquipAndItemCount(arg_26_0, arg_26_1)
	if arg_26_0._itemIcon and arg_26_0._itemIcon.isShowCount then
		arg_26_0._itemIcon:isShowCount(arg_26_1)
	end

	if arg_26_0._equipIcon and arg_26_0._isEquip then
		arg_26_0._equipIcon:isShowCount(arg_26_1)
	end
end

function var_0_0.setHideLvAndBreakFlag(arg_27_0, arg_27_1)
	if arg_27_0._equipIcon and arg_27_0._isEquip then
		arg_27_0._equipIcon:setHideLvAndBreakFlag(arg_27_1)
	end
end

function var_0_0.setShowCountFlag(arg_28_0, arg_28_1)
	if arg_28_0._equipIcon and arg_28_0._isEquip then
		arg_28_0._equipIcon:setShowCountFlag(arg_28_1)
	end
end

function var_0_0.isShowName(arg_29_0, arg_29_1)
	if arg_29_0._itemIcon and arg_29_0._itemIcon.isShowName then
		arg_29_0._itemIcon:isShowName(arg_29_1)
	end
end

function var_0_0.isShowEffect(arg_30_0, arg_30_1)
	if arg_30_0._itemIcon and arg_30_0._itemIcon.isShowEffect then
		arg_30_0._itemIcon:isShowEffect(arg_30_1)
	end
end

function var_0_0.isShowAddition(arg_31_0, arg_31_1)
	if arg_31_0._itemIcon and arg_31_0._itemIcon.isShowAddition then
		arg_31_0._itemIcon:isShowAddition(arg_31_1)
	elseif arg_31_0._isEquip and arg_31_0._equipIcon then
		arg_31_0._equipIcon:isShowAddition(arg_31_1)
	end
end

function var_0_0.ShowEquipCount(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_0._isEquip and arg_32_0._equipIcon then
		arg_32_0._equipIcon:showEquipCount(arg_32_1, arg_32_2)
	end
end

function var_0_0.isShowEquipCount(arg_33_0, arg_33_1)
	if arg_33_0._isEquip and arg_33_0._equipIcon then
		arg_33_0._equipIcon:isShowCount(arg_33_1)
	end
end

function var_0_0.hideExpEquipState(arg_34_0)
	if arg_34_0._isEquip and arg_34_0._equipIcon then
		arg_34_0._equipIcon:hideExpEquipState()
	end
end

function var_0_0.hideEquipLvAndBreak(arg_35_0, arg_35_1)
	if arg_35_0._isEquip and arg_35_0._equipIcon then
		arg_35_0._equipIcon:hideLvAndBreak(arg_35_1)
	end
end

function var_0_0.showEquipRefineContainer(arg_36_0, arg_36_1)
	if arg_36_0._isEquip and arg_36_0._equipIcon then
		arg_36_0._equipIcon:showEquipRefineContainer(arg_36_1)
	end
end

function var_0_0.setCantJump(arg_37_0, arg_37_1)
	if arg_37_0._itemIcon and arg_37_0._itemIcon.setCantJump then
		arg_37_0._itemIcon:setCantJump(arg_37_1)
	end

	if arg_37_0._equipIcon and arg_37_0._equipIcon.setCantJump then
		arg_37_0._equipIcon:setCantJump(arg_37_1)
	end
end

function var_0_0.setRecordFarmItem(arg_38_0, arg_38_1)
	if arg_38_0._itemIcon and arg_38_0._itemIcon.setRecordFarmItem then
		arg_38_0._itemIcon:setRecordFarmItem(arg_38_1)
	end
end

function var_0_0.setQuantityColor(arg_39_0, arg_39_1)
	arg_39_0._quantityColor = arg_39_1

	if arg_39_0._itemIcon and arg_39_0._itemIcon.setQuantityColor then
		arg_39_0._itemIcon:setQuantityColor(arg_39_1)
	end
end

function var_0_0.setItemColor(arg_40_0, arg_40_1)
	if arg_40_0._itemIcon then
		arg_40_0._itemIcon:setItemColor(arg_40_1)
	end

	if arg_40_0._equipIcon then
		arg_40_0._equipIcon:setItemColor(arg_40_1)
	end
end

function var_0_0.showStackableNum2(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_0._itemIcon and arg_41_0._itemIcon.showStackableNum2 then
		arg_41_0._itemIcon:showStackableNum2(arg_41_1, arg_41_2)
	end
end

function var_0_0.setCountText(arg_42_0, arg_42_1)
	if arg_42_0._itemIcon then
		arg_42_0._itemIcon:setCountText(arg_42_1)
	end
end

function var_0_0.getItemIcon(arg_43_0)
	return arg_43_0._isEquip and arg_43_0._equipIcon or arg_43_0._itemIcon
end

function var_0_0.isEquipIcon(arg_44_0)
	return arg_44_0._isEquip
end

function var_0_0.setCountFontSize(arg_45_0, arg_45_1)
	if arg_45_0._equipIcon and arg_45_0._isEquip then
		arg_45_0._equipIcon:setCountFontSize(arg_45_1)
	else
		arg_45_0._itemIcon:setCountFontSize(arg_45_1)
	end
end

function var_0_0.setEquipLevelScaleAndColor(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_0._equipIcon and arg_46_0._isEquip then
		arg_46_0._equipIcon:setLevelScaleAndColor(arg_46_1, arg_46_2)
	end
end

function var_0_0.setCarrerIconAndRefineVisible(arg_47_0, arg_47_1)
	if arg_47_0._equipIcon and arg_47_0._isEquip then
		arg_47_0._equipIcon:setCarrerIconAndRefineVisible(arg_47_1)
	end
end

function var_0_0.playAnimation(arg_48_0)
	if arg_48_0._itemIcon then
		arg_48_0._itemIcon:playAnimation()
	end
end

function var_0_0.setAutoPlay(arg_49_0, arg_49_1)
	if arg_49_0._itemIcon then
		arg_49_0._itemIcon:setAutoPlay(arg_49_1)
	end
end

function var_0_0.setConsume(arg_50_0, arg_50_1)
	if arg_50_0._itemIcon then
		arg_50_0._itemIcon:setConsume(arg_50_1)
	end
end

function var_0_0.isShowEquipRefineLv(arg_51_0, arg_51_1)
	if arg_51_0._isEquip then
		arg_51_0._equipIcon:isShowRefineLv(arg_51_1)
	end
end

function var_0_0.SetCountLocalY(arg_52_0, arg_52_1)
	if arg_52_0._itemIcon and arg_52_0._itemIcon._txtQuantity then
		recthelper.setAnchorY(arg_52_0._itemIcon._txtQuantity.transform, arg_52_1)
	end

	if arg_52_0._equipIcon and arg_52_0._equipIcon._txtnum then
		recthelper.setAnchorY(arg_52_0._equipIcon._txtnum.transform, arg_52_1 - 39.6)
	end
end

function var_0_0.SetCountBgHeight(arg_53_0, arg_53_1)
	if arg_53_0._itemIcon and arg_53_0._itemIcon._countbg then
		recthelper.setHeight(arg_53_0._itemIcon._countbg.transform, arg_53_1)
	end

	if arg_53_0._equipIcon and arg_53_0._equipIcon._countbg then
		recthelper.setHeight(arg_53_0._equipIcon._countbg.transform, arg_53_1)
	end
end

function var_0_0.SetCountBgScale(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	if arg_54_0._itemIcon and arg_54_0._itemIcon._countbg then
		transformhelper.setLocalScale(arg_54_0._itemIcon._countbg.transform, arg_54_1, arg_54_2, arg_54_3)
	end

	if arg_54_0._equipIcon and arg_54_0._equipIcon._countbg then
		transformhelper.setLocalScale(arg_54_0._equipIcon._countbg.transform, arg_54_1, arg_54_2, arg_54_3)
	end
end

function var_0_0.setGetMask(arg_55_0, arg_55_1)
	if arg_55_0._itemIcon then
		arg_55_0._itemIcon:setGetMask(arg_55_1)
	end

	if arg_55_0._equipIcon then
		arg_55_0._equipIcon:setGetMask(arg_55_1)
	end
end

function var_0_0.setIconBg(arg_56_0, arg_56_1)
	if arg_56_0._itemIcon then
		arg_56_0._itemIcon:setIconBg(arg_56_1)
	end
end

function var_0_0.setCanShowDeadLine(arg_57_0, arg_57_1)
	if arg_57_0._itemIcon then
		arg_57_0._itemIcon:setCanShowDeadLine(arg_57_1)
	end
end

function var_0_0.isExpiredItem(arg_58_0)
	if arg_58_0._itemIcon then
		return arg_58_0._itemIcon:isExpiredItem()
	end

	if arg_58_0._equipIcon then
		return arg_58_0._equipIcon:isExpiredItem()
	end
end

return var_0_0
