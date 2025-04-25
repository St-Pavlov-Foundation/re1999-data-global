module("modules.ugui.icon.common.CommonEquipIcon", package.seeall)

slot0 = class("CommonEquipIcon", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageBg = gohelper.findChildImage(slot0.viewGO, "bg")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#image_rare")
	slot0._imagerare2 = gohelper.findChildImage(slot0.viewGO, "#image_rare2")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "mask/#simage_icon")
	slot0._iconImage = slot0._simageicon:GetComponent(gohelper.Type_Image)
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_lock")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_inteam/#image_heroicon")
	slot0._countbg = gohelper.findChild(slot0.viewGO, "layout/#go_num/countbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "layout/#go_num/#txt_num")
	slot0._gointeam = gohelper.findChild(slot0.viewGO, "#go_inteam")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "layout/#go_level")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level")
	slot0._txtlevelEn = gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level/lv")
	slot0._gonum = gohelper.findChild(slot0.viewGO, "layout/#go_num")
	slot0.goclickarea = gohelper.findChild(slot0.viewGO, "#go_clickarea")
	slot0.gotrial = gohelper.findChild(slot0.viewGO, "#go_trial")
	slot0._gorefinecontainer = gohelper.findChild(slot0.viewGO, "#go_refinecontainer")
	slot0._txtrefinelv = gohelper.findChildText(slot0.viewGO, "#go_refinecontainer/#txt_refinelv")
	slot0._goAddition = gohelper.findChild(slot0.viewGO, "turnback")
	slot0._gorecommend = gohelper.findChild(slot0.viewGO, "#go_recommend")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._imagerare.gameObject, false)
	gohelper.setActive(slot0._imagerare2.gameObject, false)

	slot0._showQuality = true
	slot0._effectGos = {}
	slot0._effectLoader = MultiAbLoader.New()

	slot0._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	slot0._effectLoader:startLoad(slot0.LoadEffect, slot0)

	slot0._showLockIcon = true
	slot0._cantJump = false
	slot0._hideShowBreakAndLv = false
	slot0._showCount = true

	transformhelper.setLocalPosXY(slot0.viewGO.transform, 0, 0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._isShowSelectedUI = false
	slot0._isCarrerIconAndRefineVisible = true

	gohelper.setActive(slot0._gorefinecontainer, false)
	slot0:hideHeroIcon()

	slot0._itemType = MaterialEnum.MaterialType.Equip

	slot0._gorecommend:SetActive(false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()
	end

	slot0.cus_callback = nil
	slot0.cus_callback_param = nil
end

slot1 = 4
slot2 = 5

function slot0.LoadEffect(slot0)
	if gohelper.isNil(slot0._imagerare) then
		if slot0._effectLoader then
			slot0._effectLoader:dispose()

			slot0._effectLoader = nil
		end

		return
	end

	slot0:isShowQuality(slot0._showQuality)

	slot5 = "itemEffect"
	slot0._effect = gohelper.clone(slot0._effectLoader:getFirstAssetItem():GetResource(), slot0._imagerare.gameObject, slot5)

	for slot5 = uv0, uv1 do
		slot0._effectGos[slot5] = gohelper.findChild(slot0._effect, "effect" .. tostring(slot5))
	end

	if slot0._config then
		for slot5 = uv0, uv1 do
			gohelper.setActive(slot0._effectGos[slot5], slot5 == tonumber(slot0._config.rare) and EquipModel.canShowVfx(slot0._config))
			gohelper.setActive(gohelper.findChild(slot0._effectGos[slot5], "mask"), false)
		end
	end
end

function slot0._onClick(slot0)
	if slot0.cus_callback then
		slot0.cus_callback(slot0.cus_callback_param)

		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId, false, nil, slot0._cantJump)
end

function slot0.customClick(slot0, slot1, slot2)
	slot0.cus_callback = slot1
	slot0.cus_callback_param = slot2

	slot0:addClick()
end

function slot0.setCantJump(slot0, slot1)
	slot0._cantJump = slot1
end

function slot0.addClick(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.viewGO.transform, slot1, slot1, slot1)
end

function slot0.setLevelScaleAndColor(slot0, slot1, slot2)
	transformhelper.setLocalScale(slot0._golevel.transform, slot1, slot1, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level"), slot2)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level/lv"), slot2)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0.viewGO, "layout/#go_num/#txt_num"), slot2)
end

function slot0.hideLockIcon(slot0)
	slot0._showLockIcon = false
end

function slot0.hideLv(slot0, slot1)
	slot0._hideLv = slot1

	slot0._golevel:SetActive(not slot1)
end

function slot0.hideLvAndBreak(slot0, slot1)
	slot0:hideLv(slot1)
end

function slot0.setHideLvAndBreakFlag(slot0, slot1)
	slot0._hideShowBreakAndLv = slot1
end

function slot0.playEquipAnim(slot0, slot1)
	slot0._animator:Play(slot1)
end

function slot0._initEquipByMo(slot0, slot1)
	slot0._mo = slot1
	slot0._config = slot0._mo.config
	slot0._isLock = slot0._mo.isLock
	slot0._count = slot0._mo.count
	slot0._level = slot0._mo.level
	slot0._breakLv = slot0._mo.breakLv
	slot0._refineLv = slot0._mo.refineLv
	slot0._itemId = slot0._config.id
	slot0._equipTeamPosInfo = EquipChooseListModel.instance:equipInTeam(slot0._mo.uid)
end

function slot0._initEquipByConfig(slot0, slot1, slot2)
	slot0._mo = nil
	slot0._config = slot1
	slot0._itemId = slot1.id
	slot0._isLock = false
	slot0._count = slot2
	slot0._level = 1
	slot0._breakLv = 1
	slot0._refineLv = 1
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4)
	if EquipModel.instance:getEquip(slot4) then
		slot0:_initEquipByMo(slot5)
	else
		slot0:_initEquipByConfig(EquipConfig.instance:getEquipCo(tonumber(slot2)), slot3)
	end

	slot0:initEquipType()
	slot0:refreshUI()
end

function slot0.setEquipMO(slot0, slot1)
	slot0:_initEquipByMo(slot1)
	slot0:initEquipType()
	slot0:refreshUI()
end

function slot0.initEquipType(slot0)
	slot0.isExpEquip = EquipHelper.isExpEquip(slot0._config)
	slot0.isSpRefineEquip = EquipHelper.isSpRefineEquip(slot0._config)
	slot0.isRefineUniversalEquip = EquipHelper.isRefineUniversalMaterials(slot0._config.id)
	slot0.isNormalEquip = not slot0.isExpEquip and not slot0.isSpRefineEquip and not slot0.isRefineUniversalEquip
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setEquipMO(slot1)
end

function slot0.isUniversalMeterial(slot0)
	return slot0._config.id == 1000
end

function slot0.setBalanceLv(slot0, slot1)
	if not slot1 or not slot0._mo or tonumber(slot0._mo.uid) < 0 or slot1 <= slot0._level then
		return
	end

	slot0._txtlevel.text = "<color=#bfdaff>" .. slot1

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevelEn, "#bfdaff")
end

function slot0.refreshUI(slot0)
	if not slot0._config then
		return
	end

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(slot0._config.rare), nil, slot0.bgAlpha)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare2, "bgequip" .. tostring(ItemEnum.Color[slot0._config.rare]), nil, slot0.bgAlpha)

	if slot0._effectGos and tabletool.len(slot0._effectGos) > 0 then
		for slot4 = uv0, uv1 do
			gohelper.setActive(slot0._effectGos[slot4], slot4 == tonumber(slot0._config.rare) and EquipModel.canShowVfx(slot0._config))
			gohelper.setActive(gohelper.findChild(slot0._effectGos[slot4], "mask"), false)
		end
	end

	slot0._txtnum.text = GameUtil.numberDisplay(slot0._count)
	slot0._txtlevel.text = slot0._level

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevelEn, "#E8E7E7")
	gohelper.setActive(slot0.gotrial, slot0._mo and slot0._mo.equipType == EquipEnum.ClientEquipType.TrialEquip)
	gohelper.setActive(slot0._gorefinecontainer, slot0._mo and slot0.isNormalEquip)

	if slot0.isNormalEquip then
		if EquipConfig.instance:getEquipRefineLvMax() <= slot0._refineLv then
			slot0._txtrefinelv.text = string.format("<color=#e87826>%s</color>", slot0._refineLv)
		else
			slot0._txtrefinelv.text = string.format("<color=#E8E7E7>%s</color>", slot0._refineLv)
		end
	end

	slot0:_loadIconImage()
	slot0:hideLvAndBreak(EquipHelper.isRefineUniversalMaterials(slot0._config.id) or slot0.isExpEquip or EquipHelper.isSpRefineEquip(slot0._config) or slot0._hideShowBreakAndLv)
	slot0:isShowCount(not EquipHelper.isRefineUniversalMaterials(slot0._config.id) and slot0.isExpEquip and slot0._showCount)

	if not slot0._iconImage.sprite then
		slot0:_setIconAlpha(0)
	end

	slot0._golock:SetActive(slot0._isLock and slot0._showLockIcon)
end

function slot0.checkRecommend(slot0)
	slot0._gorecommend:SetActive(slot0._mo and slot0._mo.recommondIndex and slot0._mo.recommondIndex > 0)
end

function slot0._loadIconImage(slot0)
	if slot0._overrideIconLoadFunc then
		slot0._overrideIconLoadFunc(slot0._overrideIconLoadFuncObj)

		return
	end

	slot0:_defaultLoadIconFunc()
end

function slot0._defaultLoadIconFunc(slot0)
	slot0._simageicon:LoadImage(ResUrl.getEquipIcon(slot0._config.icon), slot0._loadImageFinish, slot0)
end

function slot0.setItemIconScale(slot0, slot1)
	transformhelper.setLocalScale(slot0._simageicon.transform, slot1, slot1, slot1)
end

function slot0.setItemOffset(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._simageicon.transform, slot1 or -1.5, slot2 or 53)
end

function slot0._overrideLoadIconFunc(slot0, slot1, slot2)
	slot0._overrideIconLoadFunc = slot1
	slot0._overrideIconLoadFuncObj = slot2
end

function slot0._loadImageFinish(slot0)
	slot0:_setIconAlpha(slot0.iconAlpha or 1)
end

function slot0.setAlpha(slot0, slot1, slot2)
	slot0.iconAlpha = slot1
	slot0.bgAlpha = slot2

	slot0:_setIconAlpha(slot0.iconAlpha)
	slot0:refreshUI()
end

function slot0._setIconAlpha(slot0, slot1)
	slot2 = slot0._iconImage.color
	slot2.a = slot1
	slot0._iconImage.color = slot2
end

function slot0.showLevel(slot0)
	gohelper.setActive(slot0._gonum, false)

	slot0._txtlevel.text = slot0._level
end

function slot0.refreshLock(slot0, slot1)
	slot0._isLock = slot1

	slot0._golock:SetActive(slot0._isLock and slot0._showLockIcon)
end

function slot0.showEquipCount(slot0, slot1, slot2)
	slot2 = slot2 or slot0._txtlevel

	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._gonum, false)

	if slot0.isExpEquip then
		slot2.text = GameUtil.numberDisplay(slot0._count)

		gohelper.setActive(slot1 or slot0._golevel, slot2.text ~= nil)
	else
		slot0._txtlevel.text = slot0._level

		gohelper.setActive(slot1, false)
		gohelper.setActive(slot0._golevel, true)
	end
end

function slot0.isShowAddition(slot0, slot1)
	gohelper.setActive(slot0._goAddition, slot1)
end

function slot0.isShowCount(slot0, slot1)
	gohelper.setActive(slot0._gonum, slot1)
end

function slot0.setShowCountFlag(slot0, slot1)
	slot0._showCount = slot1
end

function slot0.hideExpEquipState(slot0)
	gohelper.setActive(slot0._gorefinecontainer, not slot0.isExpEquip)
	gohelper.setActive(slot0._gonum, false)
	gohelper.setActive(slot0._golevel, not slot0.isExpEquip)
end

function slot0.showEquipRefineContainer(slot0, slot1)
	gohelper.setActive(slot0._gorefinecontainer, slot1)
end

function slot0.setCountFontSize(slot0, slot1)
	if not slot0._scale then
		slot0._scale = slot1 / slot0._txtnum.fontSize
	end

	transformhelper.setLocalScale(slot0._countbg.transform, 1, slot0._scale, 1)

	slot0._txtnum.fontSize = slot1

	transformhelper.setLocalScale(slot0._txtlevel.transform, slot0._scale, slot0._scale, slot0._scale)
	transformhelper.setLocalPosXY(slot0._txtlevel.transform, 30, 0)
end

function slot0.setLevelPos(slot0, slot1, slot2)
	transformhelper.setLocalPosXY(slot0._txtlevel.transform, slot1, slot2)
end

function slot0.setLevelFontColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevel, slot1)
end

function slot0.setCarrerIconAndRefineVisible(slot0, slot1)
	if slot0._isCarrerIconAndRefineVisible == slot1 then
		return
	end

	slot0._isCarrerIconAndRefineVisible = slot1
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot0._isShowSelectedUI and slot1)
end

function slot0.setSelectUIVisible(slot0, slot1)
	slot0._isShowSelectedUI = slot1
end

function slot0.isShowRefineLv(slot0, slot1)
	gohelper.setActive(slot0._txtrefinelv.gameObject, slot1)
end

function slot0.setRefineLvFontSize(slot0, slot1)
	slot0._txtrefinelv.fontSize = slot1
end

function slot0.showHeroIcon(slot0, slot1)
	slot0._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(slot1.headIcon))
	gohelper.setActive(slot0._gointeam, true)
	slot0:refreshLock(false)
end

function slot0.hideHeroIcon(slot0)
	gohelper.setActive(slot0._gointeam, false)
end

function slot0.setItemColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageBg, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconImage, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare2, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._countbg:GetComponent(gohelper.Type_Image), slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtnum, slot1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevel, slot1 or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level/lv"), slot1 or "#E8E7E7")
end

function slot0.setGetMask(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._iconImage, slot1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare, slot1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagerare2, slot1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlevel, slot1 and "#525252" or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(slot0.viewGO, "layout/#go_level/#txt_level/lv"), slot1 and "#525252" or "#E8E7E7")
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtrefinelv, slot1 and 0.4 or 1)
end

function slot0.isShowQuality(slot0, slot1)
	slot0._showQuality = slot1

	gohelper.setActive(slot0._imageBg, slot1)
	gohelper.setActive(slot0._imagerare, slot1)
	gohelper.setActive(slot0._imagerare2, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end

	slot0._simageheroicon:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

function slot0.isExpiredItem(slot0)
	return false
end

return slot0
