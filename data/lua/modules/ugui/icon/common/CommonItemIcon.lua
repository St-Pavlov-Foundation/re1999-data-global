module("modules.ugui.icon.common.CommonItemIcon", package.seeall)

slot0 = class("CommonItemIcon", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._countbg = gohelper.findChild(slot1, "countbg")
	slot0._txtQuantity = gohelper.findChildText(slot1, "count")
	slot0._icon = gohelper.findChildSingleImage(slot1, "icon")
	slot0._goheadiconmask = gohelper.findChild(slot1, "headiconmask")
	slot0._playerheadicon = gohelper.findChildSingleImage(slot1, "headiconmask/playerheadicon")
	slot0._iconImage = slot0._icon:GetComponent(gohelper.Type_Image)
	slot0._txtequiplv = gohelper.findChildText(slot1, "#txt_equiplv")
	slot0._iconbg = gohelper.findChildImage(slot1, "quality")
	slot0._nameTxt = gohelper.findChildText(slot1, "txt")
	slot0._deadline = gohelper.findChild(slot1, "deadline")
	slot0._deadline1 = gohelper.findChild(slot1, "deadline1")
	slot0._imagetimebg = gohelper.findChildImage(slot0._deadline, "timebg")
	slot0._imagetimeicon = gohelper.findChildImage(slot0._deadline, "timetxt/timeicon")
	slot0._timetxt = gohelper.findChildText(slot0._deadline, "timetxt")
	slot0._formattxt = gohelper.findChildText(slot0._deadline, "timetxt/format")
	slot0._deadlineEffect = gohelper.findChild(slot0._deadline, "#effect")
	slot0._goequipcarerr = gohelper.findChild(slot1, "click/#go_equipcareer")
	slot0._gorefinebg = gohelper.findChild(slot1, "click/#go_equipcareer/#go_refinebg")
	slot0._goboth = gohelper.findChild(slot1, "click/#go_equipcareer/#go_both")
	slot0._txtrefinelv = gohelper.findChildText(slot1, "click/#go_equipcareer/#txt_refinelv")
	slot0._imagecareer = gohelper.findChildImage(slot1, "click/#go_equipcareer/#go_both/#image_carrer")
	slot0._goframe = gohelper.findChild(slot1, "headiconmask/#go_frame")
	slot0._goframenode = gohelper.findChild(slot1, "headiconmask/#go_framenode")
	slot0._goAddition = gohelper.findChild(slot1, "turnback")
	slot0._click = gohelper.getClick(slot1)
	slot0._ani = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._ani.enabled = false
	slot0._effectGos = {}
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	slot0._effectLoader:startLoad(slot0.LoadEffect, slot0)

	slot0._isEnableClick = true
	slot0._isShowCount = true
	slot0._refreshDeadline = false
	slot0.canShowDeadLine = true
	slot0._inPack = false

	gohelper.setActive(slot0._txtequiplv.gameObject, false)

	slot0._frameloader = MultiAbLoader.New()
end

function slot0.LoadEffect(slot0)
	if gohelper.isNil(slot0._iconbg) then
		if slot0._effectLoader then
			slot0._effectLoader:dispose()

			slot0._effectLoader = nil
		end

		return
	end

	slot5 = "itemEffect"
	slot0._effect = gohelper.clone(slot0._effectLoader:getFirstAssetItem():GetResource(), slot0._iconbg.gameObject, slot5)

	for slot5 = 4, 5 do
		slot0._effectGos[slot5] = gohelper.findChild(slot0._effect, "effect" .. tostring(slot5))
	end

	if slot0._showeffectrare then
		slot0:showEffect(slot0._showeffectrare)
	end
end

function slot0.playAnimation(slot0, slot1)
	slot0._ani.enabled = true

	if slot1 then
		slot0._ani:Play(slot1, 0, 0)
	else
		slot0._ani:Play("commonitemicon_in")
	end
end

function slot0.setAlpha(slot0, slot1, slot2)
	slot0.iconAlpha = slot1

	UISpriteSetMgr.instance:setCommonSprite(slot0._iconbg, "bgequip" .. tostring(ItemEnum.Color[slot0:getRare()]), nil, slot2)

	if slot0._iconImage.sprite then
		slot4 = slot0._iconImage.color
		slot4.a = slot1
		slot0._iconImage.color = slot4
	end
end

function slot0.getRare(slot0)
	return slot0._config.rare or 5
end

function slot0.setItemColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._goframe:GetComponent(gohelper.Type_Image), slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._playerheadicon:GetComponent(gohelper.Type_Image), slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconbg, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconImage, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._countbg:GetComponent(gohelper.Type_Image), slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtQuantity, slot1 or "#EBE6E6")
end

function slot0.setAutoPlay(slot0, slot1)
	slot0._ani.enabled = slot1
end

function slot0.setWidth(slot0, slot1)
	recthelper.setWidth(slot0.go.transform, slot1)
end

function slot0.getQuality(slot0)
	return slot0._iconbg
end

function slot0.getIcon(slot0)
	return slot0._icon
end

function slot0.getCountBg(slot0)
	return slot0._countbg
end

function slot0.getCount(slot0)
	return slot0._txtQuantity
end

function slot0.getDeadline1(slot0)
	return slot0._deadline1
end

function slot0.setCountText(slot0, slot1)
	slot0._txtQuantity.text = slot1
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()

		slot0._click = nil
	end
end

function slot0.setIconWithAndHeight(slot0, slot1)
	recthelper.setWidth(slot0._icon.transform, slot1)
	recthelper.setHeight(slot0._icon.transform, slot1)
end

function slot0.isEnableClick(slot0, slot1)
	slot0._isEnableClick = slot1
end

function slot0.isShowQuality(slot0, slot1)
	gohelper.setActive(slot0._iconbg.gameObject, slot1)
	gohelper.setActive(slot0._effect, slot0._isCfgNeedVfx and slot1)
end

function slot0.isShowEffect(slot0, slot1)
	slot0._showeffectrare = slot1 and slot0._showeffectrare or false

	gohelper.setActive(slot0._effect, slot0._isCfgNeedVfx and slot1)
end

function slot0.isShowName(slot0, slot1)
	gohelper.setActive(slot0._nameTxt.gameObject, slot1)
end

function slot0.isShowCount(slot0, slot1)
	slot0._isShowCount = slot1

	gohelper.setActive(slot0._txtQuantity.gameObject, slot1)
	gohelper.setActive(slot0._countbg.gameObject, slot1)
end

function slot0.isShowAddition(slot0, slot1)
	gohelper.setActive(slot0._goAddition, slot1)
end

function slot0.isShowRefinelv(slot0, slot1)
	gohelper.setActive(slot0._txtrefinelv.gameObject, slot1)
end

function slot0.isShowEquiplv(slot0, slot1)
	gohelper.setActive(slot0._txtequiplv.gameObject, slot1)
end

function slot0.showName(slot0, slot1)
	gohelper.setActive(slot0._nameTxt.gameObject, false)

	slot1 = slot1 or slot0._nameTxt

	gohelper.setActive(slot1.gameObject, true)

	slot1.text = slot0._config.name
end

function slot0.setNameType(slot0, slot1)
	slot0._nameTxt.text = string.format(slot1, slot0._config.name)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.tr, slot1, slot1, slot1)
end

function slot0.setItemIconScale(slot0, slot1)
	transformhelper.setLocalScale(slot0._icon.transform, slot1, slot1, slot1)
end

function slot0.setCountFontSize(slot0, slot1)
	if not slot0._scale then
		slot0._scale = slot1 / slot0._txtQuantity.fontSize
	end

	transformhelper.setLocalScale(slot0._countbg.transform, 1, slot0._scale, 1)

	slot0._txtQuantity.fontSize = slot1
end

function slot0.setInPack(slot0, slot1)
	slot0._inPack = slot1
end

function slot0.setConsume(slot0, slot1)
	slot0._isConsume = slot1
end

function slot0.setCanShowDeadLine(slot0, slot1)
	slot0.canShowDeadLine = slot1

	slot0:showNormalDeadline()
end

function slot0.showNormalDeadline(slot0)
	gohelper.setActive(slot0._deadline, false)

	if slot0.canShowDeadLine then
		gohelper.setActive(slot0._deadline1, slot0:_isItemHasDeadline() or slot0:_isLimitPowerPotion())
	else
		gohelper.setActive(slot0._deadline1, false)
	end
end

function slot0.SetCountLocalY(slot0, slot1)
	if slot0._txtQuantity then
		recthelper.setAnchorY(slot0._txtQuantity.transform, slot1)
	end
end

function slot0.SetCountBgHeight(slot0, slot1)
	if slot0._countbg then
		recthelper.setHeight(slot0._countbg.transform, slot1)
	end
end

function slot0.refreshDeadline(slot0, slot1)
	gohelper.setActive(slot0._deadline, true)
	gohelper.setActive(slot0._deadline1, false)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0._lasthasday = nil

	if not slot0:_isItemHasDeadline() then
		gohelper.setActive(slot0._deadline, false)
	else
		slot0._refreshDeadline = true

		slot0:_onRefreshDeadline()

		if not slot1 then
			TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
		end
	end
end

function slot0._isItemHasDeadline(slot0)
	if slot0._itemType == MaterialEnum.MaterialType.Item then
		if not slot0._expireTime or slot0._expireTime == "" or slot0._expireTime == 0 then
			return false
		end

		if slot0._config.isTimeShow == 0 then
			return false
		end

		return true
	elseif slot0._itemType == MaterialEnum.MaterialType.PowerPotion then
		return slot0._config.expireType ~= 0 and slot0._expireTime ~= 0
	elseif slot0._itemType == MaterialEnum.MaterialType.NewInsight then
		return slot0._expireTime > 0
	end
end

function slot0._isLimitPowerPotion(slot0)
	if not slot0._itemUid and slot0._config.expireType == 1 then
		return true
	end

	return false
end

function slot0._onRefreshDeadline(slot0)
	slot0._hasday = false

	if not slot0:_isItemHasDeadline() then
		gohelper.setActive(slot0._deadline, false)

		return
	end

	if slot0._expireTime - ServerTime.now() <= 0 then
		if slot0._itemType == MaterialEnum.MaterialType.PowerPotion then
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(slot0._deadline, false)

			return
		elseif slot0._itemType == MaterialEnum.MaterialType.NewInsight then
			return
		end
	end

	slot0._timetxt.text, slot0._formattxt.text, slot0._hasday = TimeUtil.secondToRoughTime(slot1, true)

	if slot0._itemType == MaterialEnum.MaterialType.NewInsight or slot0._itemType == MaterialEnum.MaterialType.PowerPotion then
		gohelper.setActive(slot0._deadline, true)
	else
		gohelper.setActive(slot0._deadline, slot0._config.isTimeShow == 1)
	end

	if slot0._lasthasday == nil or slot0._lasthasday ~= slot0._hasday then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagetimebg, slot0._hasday and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagetimeicon, slot0._hasday and "daojishiicon_01" or "daojishiicon_02")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._timetxt, slot0._hasday and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._formattxt, slot0._hasday and "#98D687" or "#E99B56")
		gohelper.setActive(slot0._deadlineEffect, not slot0._hasday)

		slot0._lasthasday = slot0._hasday
	end
end

function slot0.showStackableNum(slot0)
	if (not slot0._config.isStackable or slot0._config.isStackable == 1) and slot0._itemQuantity >= 1 then
		slot0._txtQuantity.text = slot0:_getQuantityText(slot0._itemQuantity)

		gohelper.setActive(slot0._countbg, true)
	else
		slot0._txtQuantity.text = ""

		gohelper.setActive(slot0._countbg, false)
	end
end

function slot0.showEffect(slot0, slot1)
	slot0._showeffectrare = slot1
	slot2 = slot0._isCfgNeedVfx and slot0._showeffectrare

	gohelper.setActive(slot0._effect, slot2)

	if slot2 and slot0._effectGos and tabletool.len(slot0._effectGos) > 0 then
		for slot6 = 4, 5 do
			gohelper.setActive(slot0._effectGos[slot6], slot6 == slot1)
		end
	end
end

function slot0.setCantJump(slot0, slot1)
	slot0._cantJump = slot1
end

function slot0.setRecordFarmItem(slot0, slot1)
	slot0._recordFarmItem = slot1
end

function slot0.setQuantityColor(slot0, slot1)
	slot0._quantityColor = slot1
end

function slot0.showStackableNum2(slot0, slot1, slot2)
	if (slot0._itemType == MaterialEnum.MaterialType.Hero or slot0._itemType == MaterialEnum.MaterialType.HeroSkin or slot0._itemType == MaterialEnum.MaterialType.PlayerCloth or slot0._itemType == MaterialEnum.MaterialType.PlayerCloth) and slot0._itemQuantity <= 1 then
		(slot2 or slot0._txtQuantity).text = ""

		gohelper.setActive(slot1 or slot0._countbg, false)
	elseif (not slot0._config.isStackable or slot0._config.isStackable == 1 or slot0._itemType == MaterialEnum.MaterialType.Equip or tonumber(slot0._config.subType) == ItemEnum.SubType.Portrait) and slot0._itemQuantity then
		slot2.text = slot0:_getQuantityText(slot0._itemQuantity)

		gohelper.setActive(slot1, true)
	else
		slot2.text = ""

		gohelper.setActive(slot1, false)
	end
end

function slot0._getQuantityText(slot0, slot1)
	if slot0._quantityColor then
		return string.format("<color=%s>%s</color>", slot0._quantityColor, GameUtil.numberDisplay(slot1))
	else
		return GameUtil.numberDisplay(slot1)
	end
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._itemType = tonumber(slot1)
	slot0._itemId = slot2
	slot0._itemQuantity = tonumber(slot3)
	slot0._itemUid = slot4
	slot7 = slot6 and slot6.specificIcon
	slot0._config, slot9 = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, slot5)

	if slot0._itemType == MaterialEnum.MaterialType.PowerPotion then
		if ItemPowerModel.instance:getPowerItemDeadline(slot0._itemUid) and slot10 > 0 and ItemConfig.instance:getPowerItemCo(slot0._itemId).expireType ~= 0 then
			slot0._expireTime = slot10
		else
			slot0._expireTime = 0
		end
	elseif slot0._itemType == MaterialEnum.MaterialType.NewInsight then
		if slot0._itemUid then
			slot0._expireTime = ItemInsightModel.instance:getInsightItemDeadline(slot0._itemUid)
		else
			slot0._expireTime = ItemConfig.instance:getInsightItemCo(tonumber(slot0._itemId)).expireHours
		end
	elseif string.nilorempty(slot0._config.expireTime) then
		slot0._expireTime = 0
	else
		slot0._expireTime = TimeUtil.stringToTimestamp(slot0._config.expireTime)
	end

	if slot7 then
		slot9 = slot7
	end

	slot10 = tonumber(slot8.subType) == ItemEnum.SubType.Portrait

	if string.nilorempty(slot9) then
		logError("icon为空")
	else
		if not slot0._iconImage.sprite then
			slot0:_setIconAlpha(0)
		end

		if slot10 then
			if not slot0._liveHeadIcon then
				slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._playerheadicon)
			end

			slot0._liveHeadIcon:setLiveHead(slot8.id, nil, , function (slot0, slot1)
				slot1:setAlpha(slot0.iconAlpha or 1)
			end, slot0)

			if #string.split(slot0._config.effect, "#") > 1 and slot0._config.id == tonumber(slot11[#slot11]) then
				gohelper.setActive(slot0._goframe, false)
				gohelper.setActive(slot0._goframenode, true)

				if not slot0.frame and not slot0.isloading then
					slot0.isloading = true

					slot0._frameloader:addPath("ui/viewres/common/effect/frame.prefab")
					slot0._frameloader:startLoad(slot0._onFrameLoadCallback, slot0)
				end
			else
				gohelper.setActive(slot0._goframe, true)
				gohelper.setActive(slot0._goframenode, false)
			end
		else
			slot0._icon:LoadImage(slot9, slot0._loadImageFinish, slot0)
		end
	end

	slot0:refreshItemEffect()

	if tonumber(slot1) == MaterialEnum.MaterialType.Hero and not slot5 or tonumber(slot1) == MaterialEnum.MaterialType.HeroSkin or tonumber(slot1) == MaterialEnum.MaterialType.Equip then
		recthelper.setWidth(slot0._icon.transform, 248)
		recthelper.setHeight(slot0._icon.transform, 248)
		slot0:_setIconPos(0, 0)
	elseif tonumber(slot1) == MaterialEnum.MaterialType.BlockPackage or tonumber(slot1) == MaterialEnum.MaterialType.SpecialBlock then
		slot0:_setIconPos(-1, 12.5)
	else
		recthelper.setWidth(slot0._icon.transform, 256)
		recthelper.setHeight(slot0._icon.transform, 256)
		slot0:_setIconPos(0, -7)
	end

	slot11 = slot8.rare and slot8.rare or 5

	slot0:setIconBg("bgequip" .. tostring(ItemEnum.Color[slot11]))

	slot0._isCfgNeedVfx = ItemModel.canShowVfx(slot0._itemType, slot8, slot11)

	gohelper.setActive(slot0._goheadiconmask.gameObject, slot10)
	gohelper.setActive(slot0._icon.gameObject, not slot10)
	slot0:showStackableNum2()
	slot0:refreshEquipInfo()

	if slot0._inPack then
		slot0:refreshDeadline()
	else
		slot0:showNormalDeadline()
	end

	slot0:showEffect(slot11)
end

function slot0.setRoomBuildingLevel(slot0, slot1)
	slot0._roomBuildingLevel = slot1
end

function slot0.setSpecificIcon(slot0, slot1)
	if string.nilorempty(slot1) or not slot0._icon then
		return
	end

	slot0._icon:UnLoadImage()
	slot0._icon:LoadImage(slot1, slot0._loadImageFinish, slot0)
end

function slot0.refreshItemEffect(slot0)
	if ItemEnum.ItemIconEffect[string.format("%s#%s", slot0._itemType, slot0._itemId)] then
		if string.format("ui/viewres/common/effect/propitem_%s_%s.prefab", slot0._itemType, slot0._itemId) == slot0.iconEffectPath then
			return
		end

		if slot0.iconEffectGo then
			gohelper.destroy(slot0.iconEffectGo)

			slot0.iconEffectGo = nil
		end

		slot0.iconEffectPath = slot2

		if slot0._iconEffectloader then
			slot0._iconEffectloader:dispose()

			slot0._iconEffectloader = nil
		end

		slot0._iconEffectloader = MultiAbLoader.New()

		slot0._iconEffectloader:addPath(slot2)
		slot0._iconEffectloader:startLoad(slot0._onIconEffectLoadCallback, slot0)
	else
		gohelper.setActive(slot0.iconEffectGo, false)
	end
end

function slot0._onIconEffectLoadCallback(slot0)
	if not slot0._iconEffectloader then
		return
	end

	slot1 = slot0.iconEffectPath
	slot0.iconEffectGo = gohelper.clone(slot0._iconEffectloader:getAssetItem(slot1):GetResource(slot1), slot0._icon.gameObject, slot1)
end

function slot0._setIconPos(slot0, slot1, slot2)
	if slot0._iconPosX == slot1 and slot0._iconPosY == slot2 then
		return
	end

	slot0._iconPosX = slot1
	slot0._iconPosY = slot2

	transformhelper.setLocalPosXY(slot0._icon.transform, slot1, slot2)
end

function slot0.setIconBg(slot0, slot1)
	UISpriteSetMgr.instance:setCommonSprite(slot0._iconbg, slot1)
end

function slot0.setItemOffset(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._icon.transform, slot1 or -1, slot2 or 0)
end

function slot0._onFrameLoadCallback(slot0)
	slot0.isloading = false

	gohelper.clone(slot0._frameloader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")

	slot0.frame = gohelper.findChild(slot0._goframenode, "frame")
end

function slot0._setFrameMaskable(slot0, slot1)
	if gohelper.findChild(slot0._goframenode, "frame/quxian") then
		slot2:GetComponent(gohelper.Type_Image).maskable = slot1
	end
end

function slot0._loadImageFinish(slot0)
	slot0:_setIconAlpha(slot0.iconAlpha or 1)

	if slot0._icon.gameObject.activeSelf then
		gohelper.setActive(slot0._icon, false)
		gohelper.setActive(slot0._icon, true)
	end
end

function slot0._setIconAlpha(slot0, slot1)
	slot2 = slot0._iconImage.color
	slot2.a = slot1
	slot0._iconImage.color = slot2
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setMOValue(slot1.materilType, slot1.materilId, slot1.quantity)
end

function slot0.refreshEquipInfo(slot0)
	if slot0._itemType == MaterialEnum.MaterialType.Equip then
		if EquipHelper.isNormalEquip(EquipConfig.instance:getEquipCo(tonumber(slot0._itemId))) then
			gohelper.setActive(slot0._goequipcarerr, true)

			slot0._txtrefinelv.text = 1

			if not string.nilorempty(EquipHelper.getEquipSkillCareer(slot1.id, 1)) and EquipHelper.isHasSkillBaseDesc(slot0._config.id, slot0._refineLv or 1) then
				UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, EquipHelper.getSkillCarrerSpecialIconName(slot3))
				gohelper.setActive(slot0._gorefinebg, false)
				gohelper.setActive(slot0._goboth, true)
			else
				gohelper.setActive(slot0._gorefinebg, true)
				gohelper.setActive(slot0._goboth, false)
			end

			gohelper.setActive(slot0._txtQuantity.gameObject, false)
			gohelper.setActive(slot0._countbg.gameObject, false)
			gohelper.setActive(slot0._txtequiplv.gameObject, true)

			slot0._txtequiplv.text = "Lv. 1"
		else
			gohelper.setActive(slot0._goequipcarerr, false)
		end
	else
		gohelper.setActive(slot0._txtequiplv.gameObject, false)
		gohelper.setActive(slot0._txtQuantity.gameObject, true)
		gohelper.setActive(slot0._goequipcarerr, false)
	end
end

function slot0.hideEquipLvAndCount(slot0)
	if slot0._itemType == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(slot0._txtequiplv.gameObject, false)
		gohelper.setActive(slot0._txtequiplv.gameObject, false)
		gohelper.setActive(slot0._goequipcarerr, false)
		slot0:isShowCount(not EquipHelper.isNormalEquip(EquipConfig.instance:getEquipCo(tonumber(slot0._itemId))))
	end
end

function slot0.setGetMask(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconImage, slot1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconbg, slot1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtQuantity, slot1 and "#525252" or "#EBE6E6")
	ZProj.UGUIHelper.SetColorAlpha(slot0._countbg:GetComponent(gohelper.Type_Image), slot1 and 0.8 or 1)
end

function slot0.onDestroy(slot0)
	if slot0._icon then
		slot0._icon:UnLoadImage()

		slot0._icon = nil
	end

	if slot0._playerheadicon then
		slot0._playerheadicon:UnLoadImage()

		slot0._playerheadicon = nil
	end

	if slot0._refreshDeadline then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end

	if slot0._frameloader then
		slot0._frameloader:dispose()

		slot0._frameloader = nil
	end

	if slot0._iconEffectloader then
		slot0._iconEffectloader:dispose()

		slot0._iconEffectloader = nil
	end
end

function slot0.customOnClickCallback(slot0, slot1, slot2)
	slot0._customCallback = slot1
	slot0.params = slot2
end

function slot0.setOnBeforeClickCallback(slot0, slot1, slot2, slot3)
	slot0.onBeforeClickCallback = slot1
	slot0.onBeforeClickCallbackObj = slot2
	slot0.onBeforeClickParam = slot3
end

function slot0.setJumpFinishCallback(slot0, slot1, slot2, slot3)
	slot0.jumpFinishCallback = slot1
	slot0.jumpFinishCallbackObj = slot2
	slot0.jumpFinishCallbackParam = slot3
end

function slot0._onClick(slot0)
	if not slot0._isEnableClick then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if slot0._customCallback then
		return slot0._customCallback(slot0.params)
	end

	if slot0.onBeforeClickCallback then
		slot0.onBeforeClickCallback(slot0.onBeforeClickCallbackObj, slot0.onBeforeClickParam, slot0)
	end

	MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId, slot0._inPack, slot0._itemUid, slot0._cantJump, slot0._recordFarmItem, nil, slot0._itemQuantity, slot0._isConsume, slot0.jumpFinishCallback, slot0.jumpFinishCallbackObj, slot0.jumpFinishCallbackParam, {
		roomBuildingLevel = slot0._roomBuildingLevel
	})
end

return slot0
