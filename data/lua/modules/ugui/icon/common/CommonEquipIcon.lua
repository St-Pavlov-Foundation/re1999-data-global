module("modules.ugui.icon.common.CommonEquipIcon", package.seeall)

local var_0_0 = class("CommonEquipIcon", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageBg = gohelper.findChildImage(arg_1_0.viewGO, "bg")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare")
	arg_1_0._imagerare2 = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare2")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "mask/#simage_icon")
	arg_1_0._iconImage = arg_1_0._simageicon:GetComponent(gohelper.Type_Image)
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_lock")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_inteam/#image_heroicon")
	arg_1_0._countbg = gohelper.findChild(arg_1_0.viewGO, "layout/#go_num/countbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_num/#txt_num")
	arg_1_0._gointeam = gohelper.findChild(arg_1_0.viewGO, "#go_inteam")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "layout/#go_level")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_level/#txt_level")
	arg_1_0._txtlevelEn = gohelper.findChildText(arg_1_0.viewGO, "layout/#go_level/#txt_level/lv")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "layout/#go_num")
	arg_1_0.goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_clickarea")
	arg_1_0.gotrial = gohelper.findChild(arg_1_0.viewGO, "#go_trial")
	arg_1_0._gorefinecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_refinecontainer")
	arg_1_0._txtrefinelv = gohelper.findChildText(arg_1_0.viewGO, "#go_refinecontainer/#txt_refinelv")
	arg_1_0._goAddition = gohelper.findChild(arg_1_0.viewGO, "turnback")
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "#go_recommend")

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
	gohelper.setActive(arg_4_0._imagerare.gameObject, false)
	gohelper.setActive(arg_4_0._imagerare2.gameObject, false)

	arg_4_0._showQuality = true
	arg_4_0._effectGos = {}
	arg_4_0._effectLoader = MultiAbLoader.New()

	arg_4_0._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	arg_4_0._effectLoader:startLoad(arg_4_0.LoadEffect, arg_4_0)

	arg_4_0._showLockIcon = true
	arg_4_0._cantJump = false
	arg_4_0._hideShowBreakAndLv = false
	arg_4_0._showCount = true

	transformhelper.setLocalPosXY(arg_4_0.viewGO.transform, 0, 0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._isShowSelectedUI = false
	arg_4_0._isCarrerIconAndRefineVisible = true

	gohelper.setActive(arg_4_0._gorefinecontainer, false)
	arg_4_0:hideHeroIcon()

	arg_4_0._itemType = MaterialEnum.MaterialType.Equip

	arg_4_0._gorecommend:SetActive(false)
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	if arg_6_0._click then
		arg_6_0._click:RemoveClickListener()
	end

	arg_6_0.cus_callback = nil
	arg_6_0.cus_callback_param = nil
end

local var_0_1 = 4
local var_0_2 = 5

function var_0_0.LoadEffect(arg_7_0)
	if gohelper.isNil(arg_7_0._imagerare) then
		if arg_7_0._effectLoader then
			arg_7_0._effectLoader:dispose()

			arg_7_0._effectLoader = nil
		end

		return
	end

	local var_7_0 = arg_7_0._effectLoader:getFirstAssetItem():GetResource()

	arg_7_0:isShowQuality(arg_7_0._showQuality)

	arg_7_0._effect = gohelper.clone(var_7_0, arg_7_0._imagerare.gameObject, "itemEffect")

	for iter_7_0 = var_0_1, var_0_2 do
		local var_7_1 = gohelper.findChild(arg_7_0._effect, "effect" .. tostring(iter_7_0))

		arg_7_0._effectGos[iter_7_0] = var_7_1
	end

	if arg_7_0._config then
		for iter_7_1 = var_0_1, var_0_2 do
			gohelper.setActive(arg_7_0._effectGos[iter_7_1], iter_7_1 == tonumber(arg_7_0._config.rare) and EquipModel.canShowVfx(arg_7_0._config))
			gohelper.setActive(gohelper.findChild(arg_7_0._effectGos[iter_7_1], "mask"), false)
		end
	end
end

function var_0_0._onClick(arg_8_0)
	if arg_8_0.cus_callback then
		arg_8_0.cus_callback(arg_8_0.cus_callback_param)

		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_8_0._itemType, arg_8_0._itemId, false, nil, arg_8_0._cantJump)
end

function var_0_0.customClick(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.cus_callback = arg_9_1
	arg_9_0.cus_callback_param = arg_9_2

	arg_9_0:addClick()
end

function var_0_0.setCantJump(arg_10_0, arg_10_1)
	arg_10_0._cantJump = arg_10_1
end

function var_0_0.addClick(arg_11_0)
	arg_11_0._click = gohelper.getClickWithAudio(arg_11_0.viewGO)

	arg_11_0._click:AddClickListener(arg_11_0._onClick, arg_11_0)
end

function var_0_0.setScale(arg_12_0, arg_12_1)
	transformhelper.setLocalScale(arg_12_0.viewGO.transform, arg_12_1, arg_12_1, arg_12_1)
end

function var_0_0.setLevelScaleAndColor(arg_13_0, arg_13_1, arg_13_2)
	transformhelper.setLocalScale(arg_13_0._golevel.transform, arg_13_1, arg_13_1, arg_13_1)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(arg_13_0.viewGO, "layout/#go_level/#txt_level"), arg_13_2)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(arg_13_0.viewGO, "layout/#go_level/#txt_level/lv"), arg_13_2)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(arg_13_0.viewGO, "layout/#go_num/#txt_num"), arg_13_2)
end

function var_0_0.hideLockIcon(arg_14_0)
	arg_14_0._showLockIcon = false
end

function var_0_0.hideLv(arg_15_0, arg_15_1)
	arg_15_0._hideLv = arg_15_1

	arg_15_0._golevel:SetActive(not arg_15_1)
end

function var_0_0.hideLvAndBreak(arg_16_0, arg_16_1)
	arg_16_0:hideLv(arg_16_1)
end

function var_0_0.setHideLvAndBreakFlag(arg_17_0, arg_17_1)
	arg_17_0._hideShowBreakAndLv = arg_17_1
end

function var_0_0.playEquipAnim(arg_18_0, arg_18_1)
	arg_18_0._animator:Play(arg_18_1)
end

function var_0_0._initEquipByMo(arg_19_0, arg_19_1)
	arg_19_0._mo = arg_19_1
	arg_19_0._config = arg_19_0._mo.config
	arg_19_0._isLock = arg_19_0._mo.isLock
	arg_19_0._count = arg_19_0._mo.count
	arg_19_0._level = arg_19_0._mo.level
	arg_19_0._breakLv = arg_19_0._mo.breakLv
	arg_19_0._refineLv = arg_19_0._mo.refineLv
	arg_19_0._itemId = arg_19_0._config.id
	arg_19_0._equipTeamPosInfo = EquipChooseListModel.instance:equipInTeam(arg_19_0._mo.uid)
end

function var_0_0._initEquipByConfig(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._mo = nil
	arg_20_0._config = arg_20_1
	arg_20_0._itemId = arg_20_1.id
	arg_20_0._isLock = false
	arg_20_0._count = arg_20_2
	arg_20_0._level = 1
	arg_20_0._breakLv = 1
	arg_20_0._refineLv = 1
end

function var_0_0.setMOValue(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = EquipModel.instance:getEquip(arg_21_4)

	if var_21_0 then
		arg_21_0:_initEquipByMo(var_21_0)
	else
		arg_21_0:_initEquipByConfig(EquipConfig.instance:getEquipCo(tonumber(arg_21_2)), arg_21_3)
	end

	arg_21_0:initEquipType()
	arg_21_0:refreshUI()
end

function var_0_0.setEquipMO(arg_22_0, arg_22_1)
	arg_22_0:_initEquipByMo(arg_22_1)
	arg_22_0:initEquipType()
	arg_22_0:refreshUI()
end

function var_0_0.initEquipType(arg_23_0)
	arg_23_0.isExpEquip = EquipHelper.isExpEquip(arg_23_0._config)
	arg_23_0.isSpRefineEquip = EquipHelper.isSpRefineEquip(arg_23_0._config)
	arg_23_0.isRefineUniversalEquip = EquipHelper.isRefineUniversalMaterials(arg_23_0._config.id)
	arg_23_0.isNormalEquip = not arg_23_0.isExpEquip and not arg_23_0.isSpRefineEquip and not arg_23_0.isRefineUniversalEquip
end

function var_0_0.onUpdateMO(arg_24_0, arg_24_1)
	arg_24_0:setEquipMO(arg_24_1)
end

function var_0_0.isUniversalMeterial(arg_25_0)
	return arg_25_0._config.id == 1000
end

function var_0_0.setBalanceLv(arg_26_0, arg_26_1)
	if not arg_26_1 or not arg_26_0._mo or tonumber(arg_26_0._mo.uid) < 0 or arg_26_1 <= arg_26_0._level then
		return
	end

	arg_26_0._txtlevel.text = "<color=#bfdaff>" .. arg_26_1

	SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._txtlevelEn, "#bfdaff")
end

function var_0_0.refreshUI(arg_27_0)
	if not arg_27_0._config then
		return
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_27_0._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(arg_27_0._config.rare), nil, arg_27_0.bgAlpha)
	UISpriteSetMgr.instance:setCommonSprite(arg_27_0._imagerare2, "bgequip" .. tostring(ItemEnum.Color[arg_27_0._config.rare]), nil, arg_27_0.bgAlpha)

	if arg_27_0._effectGos and tabletool.len(arg_27_0._effectGos) > 0 then
		for iter_27_0 = var_0_1, var_0_2 do
			gohelper.setActive(arg_27_0._effectGos[iter_27_0], iter_27_0 == tonumber(arg_27_0._config.rare) and EquipModel.canShowVfx(arg_27_0._config))
			gohelper.setActive(gohelper.findChild(arg_27_0._effectGos[iter_27_0], "mask"), false)
		end
	end

	arg_27_0._txtnum.text = GameUtil.numberDisplay(arg_27_0._count)
	arg_27_0._txtlevel.text = arg_27_0._level

	SLFramework.UGUI.GuiHelper.SetColor(arg_27_0._txtlevelEn, "#E8E7E7")
	gohelper.setActive(arg_27_0.gotrial, arg_27_0._mo and arg_27_0._mo.equipType == EquipEnum.ClientEquipType.TrialEquip)
	gohelper.setActive(arg_27_0._gorefinecontainer, arg_27_0._mo and arg_27_0.isNormalEquip)

	if arg_27_0.isNormalEquip then
		if arg_27_0._refineLv >= EquipConfig.instance:getEquipRefineLvMax() then
			arg_27_0._txtrefinelv.text = string.format("<color=#e87826>%s</color>", arg_27_0._refineLv)
		else
			arg_27_0._txtrefinelv.text = string.format("<color=#E8E7E7>%s</color>", arg_27_0._refineLv)
		end
	end

	arg_27_0:_loadIconImage()
	arg_27_0:hideLvAndBreak(EquipHelper.isRefineUniversalMaterials(arg_27_0._config.id) or arg_27_0.isExpEquip or EquipHelper.isSpRefineEquip(arg_27_0._config) or arg_27_0._hideShowBreakAndLv)
	arg_27_0:isShowCount(not EquipHelper.isRefineUniversalMaterials(arg_27_0._config.id) and arg_27_0.isExpEquip and arg_27_0._showCount)

	if not arg_27_0._iconImage.sprite then
		arg_27_0:_setIconAlpha(0)
	end

	arg_27_0._golock:SetActive(arg_27_0._isLock and arg_27_0._showLockIcon)
end

function var_0_0.checkRecommend(arg_28_0)
	local var_28_0 = arg_28_0._mo and arg_28_0._mo.recommondIndex and arg_28_0._mo.recommondIndex > 0

	arg_28_0._gorecommend:SetActive(var_28_0)
end

function var_0_0._loadIconImage(arg_29_0)
	if arg_29_0._overrideIconLoadFunc then
		arg_29_0._overrideIconLoadFunc(arg_29_0._overrideIconLoadFuncObj)

		return
	end

	arg_29_0:_defaultLoadIconFunc()
end

function var_0_0._defaultLoadIconFunc(arg_30_0)
	arg_30_0._simageicon:LoadImage(ResUrl.getEquipIcon(arg_30_0._config.icon), arg_30_0._loadImageFinish, arg_30_0)
end

function var_0_0.setItemIconScale(arg_31_0, arg_31_1)
	transformhelper.setLocalScale(arg_31_0._simageicon.transform, arg_31_1, arg_31_1, arg_31_1)
end

function var_0_0.setItemOffset(arg_32_0, arg_32_1, arg_32_2)
	recthelper.setAnchor(arg_32_0._simageicon.transform, arg_32_1 or -1.5, arg_32_2 or 53)
end

function var_0_0._overrideLoadIconFunc(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0._overrideIconLoadFunc = arg_33_1
	arg_33_0._overrideIconLoadFuncObj = arg_33_2
end

function var_0_0._loadImageFinish(arg_34_0)
	arg_34_0:_setIconAlpha(arg_34_0.iconAlpha or 1)
end

function var_0_0.setAlpha(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.iconAlpha = arg_35_1
	arg_35_0.bgAlpha = arg_35_2

	arg_35_0:_setIconAlpha(arg_35_0.iconAlpha)
	arg_35_0:refreshUI()
end

function var_0_0._setIconAlpha(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._iconImage.color

	var_36_0.a = arg_36_1
	arg_36_0._iconImage.color = var_36_0
end

function var_0_0.showLevel(arg_37_0)
	gohelper.setActive(arg_37_0._gonum, false)

	arg_37_0._txtlevel.text = arg_37_0._level
end

function var_0_0.refreshLock(arg_38_0, arg_38_1)
	arg_38_0._isLock = arg_38_1

	arg_38_0._golock:SetActive(arg_38_0._isLock and arg_38_0._showLockIcon)
end

function var_0_0.showEquipCount(arg_39_0, arg_39_1, arg_39_2)
	arg_39_1 = arg_39_1 or arg_39_0._golevel
	arg_39_2 = arg_39_2 or arg_39_0._txtlevel

	gohelper.setActive(arg_39_0._golevel, false)
	gohelper.setActive(arg_39_0._gonum, false)

	if arg_39_0.isExpEquip then
		arg_39_2.text = GameUtil.numberDisplay(arg_39_0._count)

		gohelper.setActive(arg_39_1, arg_39_2.text ~= nil)
	else
		arg_39_0._txtlevel.text = arg_39_0._level

		gohelper.setActive(arg_39_1, false)
		gohelper.setActive(arg_39_0._golevel, true)
	end
end

function var_0_0.isShowAddition(arg_40_0, arg_40_1)
	gohelper.setActive(arg_40_0._goAddition, arg_40_1)
end

function var_0_0.isShowCount(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._gonum, arg_41_1)
end

function var_0_0.setShowCountFlag(arg_42_0, arg_42_1)
	arg_42_0._showCount = arg_42_1
end

function var_0_0.hideExpEquipState(arg_43_0)
	gohelper.setActive(arg_43_0._gorefinecontainer, not arg_43_0.isExpEquip)
	gohelper.setActive(arg_43_0._gonum, false)
	gohelper.setActive(arg_43_0._golevel, not arg_43_0.isExpEquip)
end

function var_0_0.showEquipRefineContainer(arg_44_0, arg_44_1)
	gohelper.setActive(arg_44_0._gorefinecontainer, arg_44_1)
end

function var_0_0.setCountFontSize(arg_45_0, arg_45_1)
	if not arg_45_0._scale then
		arg_45_0._scale = arg_45_1 / arg_45_0._txtnum.fontSize
	end

	transformhelper.setLocalScale(arg_45_0._countbg.transform, 1, arg_45_0._scale, 1)

	arg_45_0._txtnum.fontSize = arg_45_1

	transformhelper.setLocalScale(arg_45_0._txtlevel.transform, arg_45_0._scale, arg_45_0._scale, arg_45_0._scale)
	transformhelper.setLocalPosXY(arg_45_0._txtlevel.transform, 30, 0)
end

function var_0_0.setLevelPos(arg_46_0, arg_46_1, arg_46_2)
	transformhelper.setLocalPosXY(arg_46_0._txtlevel.transform, arg_46_1, arg_46_2)
end

function var_0_0.setLevelFontColor(arg_47_0, arg_47_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_47_0._txtlevel, arg_47_1)
end

function var_0_0.setCarrerIconAndRefineVisible(arg_48_0, arg_48_1)
	if arg_48_0._isCarrerIconAndRefineVisible == arg_48_1 then
		return
	end

	arg_48_0._isCarrerIconAndRefineVisible = arg_48_1
end

function var_0_0.onSelect(arg_49_0, arg_49_1)
	gohelper.setActive(arg_49_0._goselected, arg_49_0._isShowSelectedUI and arg_49_1)
end

function var_0_0.setSelectUIVisible(arg_50_0, arg_50_1)
	arg_50_0._isShowSelectedUI = arg_50_1
end

function var_0_0.isShowRefineLv(arg_51_0, arg_51_1)
	gohelper.setActive(arg_51_0._txtrefinelv.gameObject, arg_51_1)
end

function var_0_0.setRefineLvFontSize(arg_52_0, arg_52_1)
	arg_52_0._txtrefinelv.fontSize = arg_52_1
end

function var_0_0.showHeroIcon(arg_53_0, arg_53_1)
	arg_53_0._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(arg_53_1.headIcon))
	gohelper.setActive(arg_53_0._gointeam, true)
	arg_53_0:refreshLock(false)
end

function var_0_0.hideHeroIcon(arg_54_0)
	gohelper.setActive(arg_54_0._gointeam, false)
end

function var_0_0.setItemColor(arg_55_0, arg_55_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._imageBg, arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._iconImage, arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._imagerare, arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._imagerare2, arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._countbg:GetComponent(gohelper.Type_Image), arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtnum, arg_55_1 or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_55_0._txtlevel, arg_55_1 or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(arg_55_0.viewGO, "layout/#go_level/#txt_level/lv"), arg_55_1 or "#E8E7E7")
end

function var_0_0.setGetMask(arg_56_0, arg_56_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._iconImage, arg_56_1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._imagerare, arg_56_1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._imagerare2, arg_56_1 and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._txtlevel, arg_56_1 and "#525252" or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(arg_56_0.viewGO, "layout/#go_level/#txt_level/lv"), arg_56_1 and "#525252" or "#E8E7E7")
	ZProj.UGUIHelper.SetColorAlpha(arg_56_0._txtrefinelv, arg_56_1 and 0.4 or 1)
end

function var_0_0.isShowQuality(arg_57_0, arg_57_1)
	arg_57_0._showQuality = arg_57_1

	gohelper.setActive(arg_57_0._imageBg, arg_57_1)
	gohelper.setActive(arg_57_0._imagerare, arg_57_1)
	gohelper.setActive(arg_57_0._imagerare2, arg_57_1)
end

function var_0_0.onDestroyView(arg_58_0)
	if arg_58_0._effectLoader then
		arg_58_0._effectLoader:dispose()

		arg_58_0._effectLoader = nil
	end

	arg_58_0._simageheroicon:UnLoadImage()
	arg_58_0._simageicon:UnLoadImage()
end

function var_0_0.isExpiredItem(arg_59_0)
	return false
end

return var_0_0
