module("modules.ugui.icon.common.CommonItemIcon", package.seeall)

local var_0_0 = class("CommonItemIcon", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._countbg = gohelper.findChild(arg_1_1, "countbg")
	arg_1_0._txtQuantity = gohelper.findChildText(arg_1_1, "count")
	arg_1_0._icon = gohelper.findChildSingleImage(arg_1_1, "icon")
	arg_1_0._goheadiconmask = gohelper.findChild(arg_1_1, "headiconmask")
	arg_1_0._playerheadicon = gohelper.findChildSingleImage(arg_1_1, "headiconmask/playerheadicon")
	arg_1_0._iconImage = arg_1_0._icon:GetComponent(gohelper.Type_Image)
	arg_1_0._txtequiplv = gohelper.findChildText(arg_1_1, "#txt_equiplv")
	arg_1_0._iconbg = gohelper.findChildImage(arg_1_1, "quality")
	arg_1_0._nameTxt = gohelper.findChildText(arg_1_1, "txt")
	arg_1_0._deadline = gohelper.findChild(arg_1_1, "deadline")
	arg_1_0._deadline1 = gohelper.findChild(arg_1_1, "deadline1")
	arg_1_0._imagetimebg = gohelper.findChildImage(arg_1_0._deadline, "timebg")
	arg_1_0._imagetimeicon = gohelper.findChildImage(arg_1_0._deadline, "timetxt/timeicon")
	arg_1_0._timetxt = gohelper.findChildText(arg_1_0._deadline, "timetxt")
	arg_1_0._formattxt = gohelper.findChildText(arg_1_0._deadline, "timetxt/format")
	arg_1_0._deadlineEffect = gohelper.findChild(arg_1_0._deadline, "#effect")
	arg_1_0._goequipcarerr = gohelper.findChild(arg_1_1, "click/#go_equipcareer")
	arg_1_0._gorefinebg = gohelper.findChild(arg_1_1, "click/#go_equipcareer/#go_refinebg")
	arg_1_0._goboth = gohelper.findChild(arg_1_1, "click/#go_equipcareer/#go_both")
	arg_1_0._txtrefinelv = gohelper.findChildText(arg_1_1, "click/#go_equipcareer/#txt_refinelv")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_1, "click/#go_equipcareer/#go_both/#image_carrer")
	arg_1_0._goframe = gohelper.findChild(arg_1_1, "headiconmask/#go_frame")
	arg_1_0._goframenode = gohelper.findChild(arg_1_1, "headiconmask/#go_framenode")
	arg_1_0._goAddition = gohelper.findChild(arg_1_1, "turnback")
	arg_1_0._click = gohelper.getClick(arg_1_1)
	arg_1_0._ani = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._ani.enabled = false
	arg_1_0._effectGos = {}
	arg_1_0._effectLoader = MultiAbLoader.New()

	arg_1_0._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	arg_1_0._effectLoader:startLoad(arg_1_0.LoadEffect, arg_1_0)

	arg_1_0._isEnableClick = true
	arg_1_0._isShowCount = true
	arg_1_0._refreshDeadline = false
	arg_1_0.canShowDeadLine = true
	arg_1_0._inPack = false

	gohelper.setActive(arg_1_0._txtequiplv.gameObject, false)

	arg_1_0._frameloader = MultiAbLoader.New()
end

function var_0_0.LoadEffect(arg_2_0)
	if gohelper.isNil(arg_2_0._iconbg) then
		if arg_2_0._effectLoader then
			arg_2_0._effectLoader:dispose()

			arg_2_0._effectLoader = nil
		end

		return
	end

	local var_2_0 = arg_2_0._effectLoader:getFirstAssetItem():GetResource()

	arg_2_0._effect = gohelper.clone(var_2_0, arg_2_0._iconbg.gameObject, "itemEffect")

	for iter_2_0 = 4, 5 do
		local var_2_1 = gohelper.findChild(arg_2_0._effect, "effect" .. tostring(iter_2_0))

		arg_2_0._effectGos[iter_2_0] = var_2_1
	end

	if arg_2_0._showeffectrare then
		arg_2_0:showEffect(arg_2_0._showeffectrare)
	end
end

function var_0_0.playAnimation(arg_3_0, arg_3_1)
	arg_3_0._ani.enabled = true

	if arg_3_1 then
		arg_3_0._ani:Play(arg_3_1, 0, 0)
	else
		arg_3_0._ani:Play("commonitemicon_in")
	end
end

function var_0_0.setAlpha(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.iconAlpha = arg_4_1

	local var_4_0 = arg_4_0:getRare()

	UISpriteSetMgr.instance:setCommonSprite(arg_4_0._iconbg, "bgequip" .. tostring(ItemEnum.Color[var_4_0]), nil, arg_4_2)

	if arg_4_0._iconImage.sprite then
		local var_4_1 = arg_4_0._iconImage.color

		var_4_1.a = arg_4_1
		arg_4_0._iconImage.color = var_4_1
	end
end

function var_0_0.getRare(arg_5_0)
	return arg_5_0._config.rare or 5
end

function var_0_0.setItemColor(arg_6_0, arg_6_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._goframe:GetComponent(gohelper.Type_Image), arg_6_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._playerheadicon:GetComponent(gohelper.Type_Image), arg_6_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._iconbg, arg_6_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._iconImage, arg_6_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._countbg:GetComponent(gohelper.Type_Image), arg_6_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._txtQuantity, arg_6_1 or "#EBE6E6")
end

function var_0_0.setAutoPlay(arg_7_0, arg_7_1)
	arg_7_0._ani.enabled = arg_7_1
end

function var_0_0.setWidth(arg_8_0, arg_8_1)
	recthelper.setWidth(arg_8_0.go.transform, arg_8_1)
end

function var_0_0.getQuality(arg_9_0)
	return arg_9_0._iconbg
end

function var_0_0.getIcon(arg_10_0)
	return arg_10_0._icon
end

function var_0_0.getCountBg(arg_11_0)
	return arg_11_0._countbg
end

function var_0_0.getCount(arg_12_0)
	return arg_12_0._txtQuantity
end

function var_0_0.getDeadline1(arg_13_0)
	return arg_13_0._deadline1
end

function var_0_0.setCountText(arg_14_0, arg_14_1)
	arg_14_0._txtQuantity.text = arg_14_1
end

function var_0_0.addEventListeners(arg_15_0)
	arg_15_0._click:AddClickListener(arg_15_0._onClick, arg_15_0)
end

function var_0_0.removeEventListeners(arg_16_0)
	if arg_16_0._click then
		arg_16_0._click:RemoveClickListener()

		arg_16_0._click = nil
	end
end

function var_0_0.setIconWithAndHeight(arg_17_0, arg_17_1)
	recthelper.setWidth(arg_17_0._icon.transform, arg_17_1)
	recthelper.setHeight(arg_17_0._icon.transform, arg_17_1)
end

function var_0_0.isEnableClick(arg_18_0, arg_18_1)
	arg_18_0._isEnableClick = arg_18_1
end

function var_0_0.isShowQuality(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._iconbg.gameObject, arg_19_1)
	gohelper.setActive(arg_19_0._effect, arg_19_0._isCfgNeedVfx and arg_19_1)
end

function var_0_0.isShowEffect(arg_20_0, arg_20_1)
	arg_20_0._showeffectrare = arg_20_1 and arg_20_0._showeffectrare or false

	gohelper.setActive(arg_20_0._effect, arg_20_0._isCfgNeedVfx and arg_20_1)
end

function var_0_0.isShowName(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._nameTxt.gameObject, arg_21_1)
end

function var_0_0.isShowCount(arg_22_0, arg_22_1)
	arg_22_0._isShowCount = arg_22_1

	gohelper.setActive(arg_22_0._txtQuantity.gameObject, arg_22_1)
	gohelper.setActive(arg_22_0._countbg.gameObject, arg_22_1)
end

function var_0_0.isShowAddition(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._goAddition, arg_23_1)
end

function var_0_0.isShowRefinelv(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._txtrefinelv.gameObject, arg_24_1)
end

function var_0_0.isShowEquiplv(arg_25_0, arg_25_1)
	gohelper.setActive(arg_25_0._txtequiplv.gameObject, arg_25_1)
end

function var_0_0.showName(arg_26_0, arg_26_1)
	gohelper.setActive(arg_26_0._nameTxt.gameObject, false)

	arg_26_1 = arg_26_1 or arg_26_0._nameTxt

	gohelper.setActive(arg_26_1.gameObject, true)

	arg_26_1.text = arg_26_0._config.name
end

function var_0_0.setNameType(arg_27_0, arg_27_1)
	arg_27_0._nameTxt.text = string.format(arg_27_1, arg_27_0._config.name)
end

function var_0_0.setScale(arg_28_0, arg_28_1)
	transformhelper.setLocalScale(arg_28_0.tr, arg_28_1, arg_28_1, arg_28_1)
end

function var_0_0.setItemIconScale(arg_29_0, arg_29_1)
	transformhelper.setLocalScale(arg_29_0._icon.transform, arg_29_1, arg_29_1, arg_29_1)
end

function var_0_0.setCountFontSize(arg_30_0, arg_30_1)
	if not arg_30_0._scale then
		arg_30_0._scale = arg_30_1 / arg_30_0._txtQuantity.fontSize
	end

	transformhelper.setLocalScale(arg_30_0._countbg.transform, 1, arg_30_0._scale, 1)

	arg_30_0._txtQuantity.fontSize = arg_30_1
end

function var_0_0.setInPack(arg_31_0, arg_31_1)
	arg_31_0._inPack = arg_31_1
end

function var_0_0.setConsume(arg_32_0, arg_32_1)
	arg_32_0._isConsume = arg_32_1
end

function var_0_0.setCanShowDeadLine(arg_33_0, arg_33_1)
	arg_33_0.canShowDeadLine = arg_33_1

	arg_33_0:showNormalDeadline()
end

function var_0_0.showNormalDeadline(arg_34_0)
	gohelper.setActive(arg_34_0._deadline, false)

	if arg_34_0.canShowDeadLine then
		gohelper.setActive(arg_34_0._deadline1, arg_34_0:isExpiredItem())
	else
		gohelper.setActive(arg_34_0._deadline1, false)
	end
end

function var_0_0.SetCountLocalY(arg_35_0, arg_35_1)
	if arg_35_0._txtQuantity then
		recthelper.setAnchorY(arg_35_0._txtQuantity.transform, arg_35_1)
	end
end

function var_0_0.SetCountBgHeight(arg_36_0, arg_36_1)
	if arg_36_0._countbg then
		recthelper.setHeight(arg_36_0._countbg.transform, arg_36_1)
	end
end

function var_0_0.refreshDeadline(arg_37_0, arg_37_1)
	gohelper.setActive(arg_37_0._deadline, true)
	gohelper.setActive(arg_37_0._deadline1, false)
	TaskDispatcher.cancelTask(arg_37_0._onRefreshDeadline, arg_37_0)

	arg_37_0._lasthasday = nil

	if not arg_37_0:_isItemHasDeadline() then
		gohelper.setActive(arg_37_0._deadline, false)
	else
		arg_37_0._refreshDeadline = true

		arg_37_0:_onRefreshDeadline()

		if not arg_37_1 then
			TaskDispatcher.runRepeat(arg_37_0._onRefreshDeadline, arg_37_0, 1)
		end
	end
end

function var_0_0._isItemHasDeadline(arg_38_0)
	if arg_38_0._itemType == MaterialEnum.MaterialType.Item then
		if not arg_38_0._expireTime or arg_38_0._expireTime == "" or arg_38_0._expireTime == 0 then
			return false
		end

		if arg_38_0._config.isTimeShow == 0 then
			return false
		end

		return true
	elseif arg_38_0._itemType == MaterialEnum.MaterialType.PowerPotion then
		return arg_38_0._config.expireType ~= 0 and arg_38_0._expireTime ~= 0
	elseif arg_38_0._itemType == MaterialEnum.MaterialType.NewInsight then
		return arg_38_0._expireTime > 0 and arg_38_0._expireTime ~= ItemEnum.NoExpiredNum
	end
end

function var_0_0._isLimitPowerPotion(arg_39_0)
	if not arg_39_0._itemUid and arg_39_0._config.expireType == 1 then
		return true
	end

	return false
end

function var_0_0._onRefreshDeadline(arg_40_0)
	arg_40_0._hasday = false

	if not arg_40_0:_isItemHasDeadline() then
		gohelper.setActive(arg_40_0._deadline, false)

		return
	end

	local var_40_0 = arg_40_0._expireTime - ServerTime.now()

	if var_40_0 <= 0 then
		if arg_40_0._itemType == MaterialEnum.MaterialType.PowerPotion then
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(arg_40_0._deadline, false)

			return
		elseif arg_40_0._itemType == MaterialEnum.MaterialType.NewInsight then
			return
		end
	end

	arg_40_0._timetxt.text, arg_40_0._formattxt.text, arg_40_0._hasday = TimeUtil.secondToRoughTime(var_40_0, true)

	if arg_40_0._itemType == MaterialEnum.MaterialType.NewInsight and arg_40_0._config.expireHours ~= ItemEnum.NoExpiredNum or arg_40_0._itemType == MaterialEnum.MaterialType.PowerPotion then
		gohelper.setActive(arg_40_0._deadline, true)
	else
		gohelper.setActive(arg_40_0._deadline, arg_40_0._config.isTimeShow == 1)
	end

	if arg_40_0._lasthasday == nil or arg_40_0._lasthasday ~= arg_40_0._hasday then
		UISpriteSetMgr.instance:setCommonSprite(arg_40_0._imagetimebg, arg_40_0._hasday and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(arg_40_0._imagetimeicon, arg_40_0._hasday and "daojishiicon_01" or "daojishiicon_02")
		SLFramework.UGUI.GuiHelper.SetColor(arg_40_0._timetxt, arg_40_0._hasday and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(arg_40_0._formattxt, arg_40_0._hasday and "#98D687" or "#E99B56")
		gohelper.setActive(arg_40_0._deadlineEffect, not arg_40_0._hasday)

		arg_40_0._lasthasday = arg_40_0._hasday
	end
end

function var_0_0.showStackableNum(arg_41_0)
	if (not arg_41_0._config.isStackable or arg_41_0._config.isStackable == 1) and arg_41_0._itemQuantity >= 1 then
		arg_41_0._txtQuantity.text = arg_41_0:_getQuantityText(arg_41_0._itemQuantity)

		gohelper.setActive(arg_41_0._countbg, true)
	else
		arg_41_0._txtQuantity.text = ""

		gohelper.setActive(arg_41_0._countbg, false)
	end
end

function var_0_0.showEffect(arg_42_0, arg_42_1)
	arg_42_0._showeffectrare = arg_42_1

	local var_42_0 = arg_42_0._isCfgNeedVfx and arg_42_0._showeffectrare

	gohelper.setActive(arg_42_0._effect, var_42_0)

	if var_42_0 and arg_42_0._effectGos and tabletool.len(arg_42_0._effectGos) > 0 then
		for iter_42_0 = 4, 5 do
			gohelper.setActive(arg_42_0._effectGos[iter_42_0], iter_42_0 == arg_42_1)
		end
	end
end

function var_0_0.setCantJump(arg_43_0, arg_43_1)
	arg_43_0._cantJump = arg_43_1
end

function var_0_0.setRecordFarmItem(arg_44_0, arg_44_1)
	arg_44_0._recordFarmItem = arg_44_1
end

function var_0_0.setQuantityColor(arg_45_0, arg_45_1)
	arg_45_0._quantityColor = arg_45_1
end

function var_0_0.showStackableNum2(arg_46_0, arg_46_1, arg_46_2)
	arg_46_1 = arg_46_1 or arg_46_0._countbg
	arg_46_2 = arg_46_2 or arg_46_0._txtQuantity

	if (arg_46_0._itemType == MaterialEnum.MaterialType.Hero or arg_46_0._itemType == MaterialEnum.MaterialType.HeroSkin or arg_46_0._itemType == MaterialEnum.MaterialType.PlayerCloth or arg_46_0._itemType == MaterialEnum.MaterialType.PlayerCloth) and arg_46_0._itemQuantity <= 1 then
		arg_46_2.text = ""

		gohelper.setActive(arg_46_1, false)
	elseif (not arg_46_0._config.isStackable or arg_46_0._config.isStackable == 1 or arg_46_0._itemType == MaterialEnum.MaterialType.Equip or tonumber(arg_46_0._config.subType) == ItemEnum.SubType.Portrait) and arg_46_0._itemQuantity then
		arg_46_2.text = arg_46_0:_getQuantityText(arg_46_0._itemQuantity)

		gohelper.setActive(arg_46_1, true)
	else
		arg_46_2.text = ""

		gohelper.setActive(arg_46_1, false)
	end
end

function var_0_0._getQuantityText(arg_47_0, arg_47_1)
	if arg_47_0._quantityColor then
		return string.format("<color=%s>%s</color>", arg_47_0._quantityColor, GameUtil.numberDisplay(arg_47_1))
	else
		return GameUtil.numberDisplay(arg_47_1)
	end
end

function var_0_0.setMOValue(arg_48_0, arg_48_1, arg_48_2, arg_48_3, arg_48_4, arg_48_5, arg_48_6)
	arg_48_0._itemType = tonumber(arg_48_1)
	arg_48_0._itemId = arg_48_2
	arg_48_0._itemQuantity = tonumber(arg_48_3)
	arg_48_0._itemUid = arg_48_4

	local var_48_0 = arg_48_6 and arg_48_6.specificIcon
	local var_48_1, var_48_2 = ItemModel.instance:getItemConfigAndIcon(arg_48_0._itemType, arg_48_0._itemId, arg_48_5)

	arg_48_0._config = var_48_1

	if arg_48_0._itemType == MaterialEnum.MaterialType.PowerPotion then
		local var_48_3 = ItemPowerModel.instance:getPowerItemDeadline(arg_48_0._itemUid)

		if var_48_3 and var_48_3 > 0 and ItemConfig.instance:getPowerItemCo(arg_48_0._itemId).expireType ~= 0 then
			arg_48_0._expireTime = var_48_3
		else
			arg_48_0._expireTime = 0
		end
	elseif arg_48_0._itemType == MaterialEnum.MaterialType.NewInsight then
		if arg_48_0._itemUid then
			arg_48_0._expireTime = ItemInsightModel.instance:getInsightItemDeadline(arg_48_0._itemUid)
		else
			arg_48_0._expireTime = ItemConfig.instance:getInsightItemCo(tonumber(arg_48_0._itemId)).expireHours
		end
	elseif string.nilorempty(arg_48_0._config.expireTime) then
		arg_48_0._expireTime = 0
	else
		arg_48_0._expireTime = TimeUtil.stringToTimestamp(arg_48_0._config.expireTime)
	end

	if var_48_0 then
		var_48_2 = var_48_0
	end

	local var_48_4 = tonumber(var_48_1.subType) == ItemEnum.SubType.Portrait

	if string.nilorempty(var_48_2) then
		logError("icon为空")
	else
		if not arg_48_0._iconImage.sprite then
			arg_48_0:_setIconAlpha(0)
		end

		if var_48_4 then
			if not arg_48_0._liveHeadIcon then
				arg_48_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_48_0._playerheadicon)
			end

			arg_48_0._liveHeadIcon:setLiveHead(var_48_1.id, nil, nil, function(arg_49_0, arg_49_1)
				local var_49_0 = arg_49_0.iconAlpha or 1

				arg_49_1:setAlpha(var_49_0)
			end, arg_48_0)

			local var_48_5 = string.split(arg_48_0._config.effect, "#")

			if #var_48_5 > 1 and arg_48_0._config.id == tonumber(var_48_5[#var_48_5]) then
				gohelper.setActive(arg_48_0._goframe, false)
				gohelper.setActive(arg_48_0._goframenode, true)

				if not arg_48_0.frame and not arg_48_0.isloading then
					arg_48_0.isloading = true

					local var_48_6 = "ui/viewres/common/effect/frame.prefab"

					arg_48_0._frameloader:addPath(var_48_6)
					arg_48_0._frameloader:startLoad(arg_48_0._onFrameLoadCallback, arg_48_0)
				end
			else
				gohelper.setActive(arg_48_0._goframe, true)
				gohelper.setActive(arg_48_0._goframenode, false)
			end
		else
			arg_48_0._icon:LoadImage(var_48_2, arg_48_0._loadImageFinish, arg_48_0)
		end
	end

	arg_48_0:refreshItemEffect()

	if tonumber(arg_48_1) == MaterialEnum.MaterialType.Hero and not arg_48_5 or tonumber(arg_48_1) == MaterialEnum.MaterialType.HeroSkin or tonumber(arg_48_1) == MaterialEnum.MaterialType.Equip then
		recthelper.setWidth(arg_48_0._icon.transform, 248)
		recthelper.setHeight(arg_48_0._icon.transform, 248)
		arg_48_0:_setIconPos(0, 0)
	elseif tonumber(arg_48_1) == MaterialEnum.MaterialType.BlockPackage or tonumber(arg_48_1) == MaterialEnum.MaterialType.SpecialBlock then
		arg_48_0:_setIconPos(-1, 12.5)
	else
		recthelper.setWidth(arg_48_0._icon.transform, 256)
		recthelper.setHeight(arg_48_0._icon.transform, 256)
		arg_48_0:_setIconPos(0, -7)
	end

	local var_48_7 = var_48_1.rare and var_48_1.rare or 5

	arg_48_0:setIconBg("bgequip" .. tostring(ItemEnum.Color[var_48_7]))

	arg_48_0._isCfgNeedVfx = ItemModel.canShowVfx(arg_48_0._itemType, var_48_1, var_48_7)

	gohelper.setActive(arg_48_0._goheadiconmask.gameObject, var_48_4)
	gohelper.setActive(arg_48_0._icon.gameObject, not var_48_4)
	arg_48_0:showStackableNum2()
	arg_48_0:refreshEquipInfo()

	if arg_48_0._inPack then
		arg_48_0:refreshDeadline()
	else
		arg_48_0:showNormalDeadline()
	end

	arg_48_0:showEffect(var_48_7)
end

function var_0_0.setRoomBuildingLevel(arg_50_0, arg_50_1)
	arg_50_0._roomBuildingLevel = arg_50_1
end

function var_0_0.setSpecificIcon(arg_51_0, arg_51_1)
	if string.nilorempty(arg_51_1) or not arg_51_0._icon then
		return
	end

	arg_51_0._icon:UnLoadImage()
	arg_51_0._icon:LoadImage(arg_51_1, arg_51_0._loadImageFinish, arg_51_0)
end

function var_0_0.refreshItemEffect(arg_52_0)
	if ItemEnum.ItemIconEffect[string.format("%s#%s", arg_52_0._itemType, arg_52_0._itemId)] then
		local var_52_0 = string.format("ui/viewres/common/effect/propitem_%s_%s.prefab", arg_52_0._itemType, arg_52_0._itemId)

		if var_52_0 == arg_52_0.iconEffectPath then
			return
		end

		if arg_52_0.iconEffectGo then
			gohelper.destroy(arg_52_0.iconEffectGo)

			arg_52_0.iconEffectGo = nil
		end

		arg_52_0.iconEffectPath = var_52_0

		if arg_52_0._iconEffectloader then
			arg_52_0._iconEffectloader:dispose()

			arg_52_0._iconEffectloader = nil
		end

		arg_52_0._iconEffectloader = MultiAbLoader.New()

		arg_52_0._iconEffectloader:addPath(var_52_0)
		arg_52_0._iconEffectloader:startLoad(arg_52_0._onIconEffectLoadCallback, arg_52_0)
	else
		gohelper.setActive(arg_52_0.iconEffectGo, false)
	end
end

function var_0_0._onIconEffectLoadCallback(arg_53_0)
	if not arg_53_0._iconEffectloader then
		return
	end

	local var_53_0 = arg_53_0.iconEffectPath
	local var_53_1 = arg_53_0._iconEffectloader:getAssetItem(var_53_0):GetResource(var_53_0)

	arg_53_0.iconEffectGo = gohelper.clone(var_53_1, arg_53_0._icon.gameObject, var_53_0)
end

function var_0_0._setIconPos(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_0._iconPosX == arg_54_1 and arg_54_0._iconPosY == arg_54_2 then
		return
	end

	arg_54_0._iconPosX = arg_54_1
	arg_54_0._iconPosY = arg_54_2

	transformhelper.setLocalPosXY(arg_54_0._icon.transform, arg_54_1, arg_54_2)
end

function var_0_0.setIconBg(arg_55_0, arg_55_1)
	UISpriteSetMgr.instance:setCommonSprite(arg_55_0._iconbg, arg_55_1)
end

function var_0_0.setItemOffset(arg_56_0, arg_56_1, arg_56_2)
	recthelper.setAnchor(arg_56_0._icon.transform, arg_56_1 or -1, arg_56_2 or 0)
end

function var_0_0._onFrameLoadCallback(arg_57_0)
	arg_57_0.isloading = false

	local var_57_0 = arg_57_0._frameloader:getFirstAssetItem():GetResource()

	gohelper.clone(var_57_0, arg_57_0._goframenode, "frame")

	arg_57_0.frame = gohelper.findChild(arg_57_0._goframenode, "frame")
end

function var_0_0._setFrameMaskable(arg_58_0, arg_58_1)
	local var_58_0 = gohelper.findChild(arg_58_0._goframenode, "frame/quxian")

	if var_58_0 then
		var_58_0:GetComponent(gohelper.Type_Image).maskable = arg_58_1
	end
end

function var_0_0._loadImageFinish(arg_59_0)
	arg_59_0:_setIconAlpha(arg_59_0.iconAlpha or 1)

	if arg_59_0._icon.gameObject.activeSelf then
		gohelper.setActive(arg_59_0._icon, false)
		gohelper.setActive(arg_59_0._icon, true)
	end
end

function var_0_0._setIconAlpha(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._iconImage.color

	var_60_0.a = arg_60_1
	arg_60_0._iconImage.color = var_60_0
end

function var_0_0.onUpdateMO(arg_61_0, arg_61_1)
	arg_61_0:setMOValue(arg_61_1.materilType, arg_61_1.materilId, arg_61_1.quantity)
end

function var_0_0.refreshEquipInfo(arg_62_0)
	if arg_62_0._itemType == MaterialEnum.MaterialType.Equip then
		local var_62_0 = EquipConfig.instance:getEquipCo(tonumber(arg_62_0._itemId))

		if EquipHelper.isNormalEquip(var_62_0) then
			gohelper.setActive(arg_62_0._goequipcarerr, true)

			arg_62_0._txtrefinelv.text = 1

			local var_62_1 = EquipHelper.getEquipSkillCareer(var_62_0.id, 1)
			local var_62_2 = EquipHelper.isHasSkillBaseDesc(arg_62_0._config.id, arg_62_0._refineLv or 1)

			if not string.nilorempty(var_62_1) and var_62_2 then
				local var_62_3 = EquipHelper.getSkillCarrerSpecialIconName(var_62_1)

				UISpriteSetMgr.instance:setCommonSprite(arg_62_0._imagecareer, var_62_3)
				gohelper.setActive(arg_62_0._gorefinebg, false)
				gohelper.setActive(arg_62_0._goboth, true)
			else
				gohelper.setActive(arg_62_0._gorefinebg, true)
				gohelper.setActive(arg_62_0._goboth, false)
			end

			gohelper.setActive(arg_62_0._txtQuantity.gameObject, false)
			gohelper.setActive(arg_62_0._countbg.gameObject, false)
			gohelper.setActive(arg_62_0._txtequiplv.gameObject, true)

			arg_62_0._txtequiplv.text = "Lv. 1"
		else
			gohelper.setActive(arg_62_0._goequipcarerr, false)
		end
	else
		gohelper.setActive(arg_62_0._txtequiplv.gameObject, false)
		gohelper.setActive(arg_62_0._txtQuantity.gameObject, true)
		gohelper.setActive(arg_62_0._goequipcarerr, false)
	end
end

function var_0_0.hideEquipLvAndCount(arg_63_0)
	if arg_63_0._itemType == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(arg_63_0._txtequiplv.gameObject, false)

		local var_63_0 = EquipConfig.instance:getEquipCo(tonumber(arg_63_0._itemId))
		local var_63_1 = EquipHelper.isNormalEquip(var_63_0)

		gohelper.setActive(arg_63_0._txtequiplv.gameObject, false)
		gohelper.setActive(arg_63_0._goequipcarerr, false)
		arg_63_0:isShowCount(not var_63_1)
	end
end

function var_0_0.setGetMask(arg_64_0, arg_64_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_64_0._iconImage, arg_64_1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_64_0._iconbg, arg_64_1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_64_0._txtQuantity, arg_64_1 and "#525252" or "#EBE6E6")
	ZProj.UGUIHelper.SetColorAlpha(arg_64_0._countbg:GetComponent(gohelper.Type_Image), arg_64_1 and 0.8 or 1)
end

function var_0_0.onDestroy(arg_65_0)
	if arg_65_0._icon then
		arg_65_0._icon:UnLoadImage()

		arg_65_0._icon = nil
	end

	if arg_65_0._playerheadicon then
		arg_65_0._playerheadicon:UnLoadImage()

		arg_65_0._playerheadicon = nil
	end

	if arg_65_0._refreshDeadline then
		TaskDispatcher.cancelTask(arg_65_0._onRefreshDeadline, arg_65_0)
	end

	if arg_65_0._effectLoader then
		arg_65_0._effectLoader:dispose()

		arg_65_0._effectLoader = nil
	end

	if arg_65_0._frameloader then
		arg_65_0._frameloader:dispose()

		arg_65_0._frameloader = nil
	end

	if arg_65_0._iconEffectloader then
		arg_65_0._iconEffectloader:dispose()

		arg_65_0._iconEffectloader = nil
	end
end

function var_0_0.customOnClickCallback(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0._customCallback = arg_66_1
	arg_66_0.params = arg_66_2
end

function var_0_0.setOnBeforeClickCallback(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	arg_67_0.onBeforeClickCallback = arg_67_1
	arg_67_0.onBeforeClickCallbackObj = arg_67_2
	arg_67_0.onBeforeClickParam = arg_67_3
end

function var_0_0.setJumpFinishCallback(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	arg_68_0.jumpFinishCallback = arg_68_1
	arg_68_0.jumpFinishCallbackObj = arg_68_2
	arg_68_0.jumpFinishCallbackParam = arg_68_3
end

function var_0_0._onClick(arg_69_0)
	if not arg_69_0._isEnableClick then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if arg_69_0._customCallback then
		return arg_69_0._customCallback(arg_69_0.params)
	end

	if arg_69_0.onBeforeClickCallback then
		arg_69_0.onBeforeClickCallback(arg_69_0.onBeforeClickCallbackObj, arg_69_0.onBeforeClickParam, arg_69_0)
	end

	local var_69_0 = {
		roomBuildingLevel = arg_69_0._roomBuildingLevel
	}

	MaterialTipController.instance:showMaterialInfo(arg_69_0._itemType, arg_69_0._itemId, arg_69_0._inPack, arg_69_0._itemUid, arg_69_0._cantJump, arg_69_0._recordFarmItem, nil, arg_69_0._itemQuantity, arg_69_0._isConsume, arg_69_0.jumpFinishCallback, arg_69_0.jumpFinishCallbackObj, arg_69_0.jumpFinishCallbackParam, var_69_0)
end

function var_0_0.isExpiredItem(arg_70_0)
	return arg_70_0:_isItemHasDeadline() or arg_70_0:_isLimitPowerPotion()
end

return var_0_0
