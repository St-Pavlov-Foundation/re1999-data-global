module("modules.logic.store.view.StoreSkinGoodsItem", package.seeall)

local var_0_0 = class("StoreSkinGoodsItem", ListScrollCellExtend)
local var_0_1 = {
	30,
	15,
	0
}
local var_0_2 = "singlebg/characterskin/bg_beijing.png"
local var_0_3 = {
	376,
	780
}
local var_0_4 = {
	500,
	780
}
local var_0_5 = "singlebg/signature/color/img_dressing1.png"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NormalSkin/#simage_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NormalSkin/#simage_icon")
	arg_1_0._simageg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NormalSkin/#simage_g")
	arg_1_0._goNormalSkin = gohelper.findChild(arg_1_0.viewGO, "#go_NormalSkin")
	arg_1_0._advanceImagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#simage_bg")
	arg_1_0._advanceImageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#simage_icon")
	arg_1_0._advanceImage1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#image_D")
	arg_1_0._advanceImage2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#image_A")
	arg_1_0._goAdvanceSkin = gohelper.findChild(arg_1_0.viewGO, "#go_AdvancedSkin")
	arg_1_0._goUniqueSkinsImage = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon")
	arg_1_0._goUniqueSkin = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin")
	arg_1_0._uniqueImageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon")
	arg_1_0._goUniqueImageicon2 = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon2")
	arg_1_0._uniqueSingleImageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon")
	arg_1_0._uniqueImagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UniqueSkin/#simage_iconbg")
	arg_1_0._goUniqueSkinBubble = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#simage_bubble")
	arg_1_0._govx_iconbg = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/vx_iconbg")
	arg_1_0._govx_bg = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/vx_bg")
	arg_1_0._mask = arg_1_0._goUniqueImageicon2:GetComponent(typeof(UnityEngine.UI.Mask))
	arg_1_0._goLinkageLetterG = gohelper.findChild(arg_1_0.viewGO, "#go_Linkage/#simage_g")
	arg_1_0._goLinkageLetterA = gohelper.findChild(arg_1_0.viewGO, "#go_Linkage/#image_A")
	arg_1_0._goLinkageBgG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Linkage/#simage_bg")
	arg_1_0._goLinkageBgA = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Linkage/#simage_bgA")
	arg_1_0._simagesign = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_sign")
	arg_1_0._godeduction = gohelper.findChild(arg_1_0.viewGO, "cost/#go_deduction")
	arg_1_0._txtdeduction = gohelper.findChildTextMesh(arg_1_0.viewGO, "cost/#go_deduction/txt_materialNum")
	arg_1_0._goprice = gohelper.findChild(arg_1_0.viewGO, "cost/#go_price")
	arg_1_0._goowned = gohelper.findChild(arg_1_0.viewGO, "cost/#go_owned")
	arg_1_0._txtoriginalprice = gohelper.findChildText(arg_1_0.viewGO, "cost/#txt_original_price")
	arg_1_0._goCharge = gohelper.findChild(arg_1_0.viewGO, "cost/#go_charge")
	arg_1_0._txtCharge = gohelper.findChildText(arg_1_0.viewGO, "cost/#go_charge/txt_chargeNum")
	arg_1_0._txtOriginalCharge = gohelper.findChildText(arg_1_0.viewGO, "cost/#go_charge/txt_originalChargeNum")
	arg_1_0._txtskinname = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinname")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinname/#txt_name")
	arg_1_0._goremaintime = gohelper.findChild(arg_1_0.viewGO, "#go_remaintime")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#go_remaintime/bg/icon/#txt_remaintime")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "#go_tag")
	arg_1_0._gonewtag = gohelper.findChild(arg_1_0.viewGO, "#go_newtag")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "#go_tag/bg/#txt_discount")
	arg_1_0._goSkinTips = gohelper.findChild(arg_1_0.viewGO, "#go_SkinTips")
	arg_1_0._imgProp = gohelper.findChildImage(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	arg_1_0._txtPropNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, arg_2_0.refreshChargeInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, arg_3_0.refreshChargeInfo, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))
	arg_4_0._simageg:LoadImage(ResUrl.getCharacterSkinIcon("img_g"))

	arg_4_0._txtmaterialNum = gohelper.findChildText(arg_4_0._goprice, "txt_materialNum")
	arg_4_0._simagematerial = gohelper.findChildImage(arg_4_0._goprice, "simage_material")
	arg_4_0._goLinkage = gohelper.findChild(arg_4_0.viewGO, "#go_Linkage")
	arg_4_0._goLinkageLogo = gohelper.findChild(arg_4_0.viewGO, "#go_Linkage/image_Logo")
	arg_4_0._linkage_simageicon = gohelper.findChildSingleImage(arg_4_0._goLinkage, "#simage_icon")
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO, AudioEnum.UI.play_ui_rolesopen)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._mask.enabled = false
	arg_4_0.viewGOTrs = arg_4_0.viewGO.transform
	arg_4_0.parentViewGO = arg_4_0.viewGO.transform.parent.gameObject
end

function var_0_0._onClick(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstNum(ConstEnum.BPSkinFaceViewSkinId)

	if arg_5_0._skinId == var_5_0 and BpController.instance:isEmptySkinFaceViewStr(var_5_0) then
		ViewMgr.instance:openView(ViewName.BPSkinFaceView_Store, {
			skinId = arg_5_0._skinId,
			openType = BPSkinFaceView.OPEN_TYPE.StoreSkin,
			closeCallback = arg_5_0._openStoreSkinView,
			cbObj = arg_5_0
		})
	else
		arg_5_0:_openStoreSkinView()
	end
end

function var_0_0._openStoreSkinView(arg_6_0)
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = arg_6_0._mo
	})
end

function var_0_0._onDraggingBegin(arg_7_0)
	if arg_7_0:_isUniqueSkin() and arg_7_0._skinSpineGO2 then
		arg_7_0._mask.enabled = true
	end
end

function var_0_0._onDragging(arg_8_0)
	if arg_8_0:_isUniqueSkin() and arg_8_0._skinSpineGO2 then
		local var_8_0 = arg_8_0.viewGO.transform
		local var_8_1 = recthelper.getWidth(var_8_0) * 0.5

		recthelper.setAnchorX(var_8_0, -var_8_1)

		local var_8_2 = arg_8_0.viewGO.transform.parent.parent.parent
		local var_8_3 = arg_8_0:checkItemInGoodsList(var_8_2, var_8_0)

		recthelper.setAnchorX(var_8_0, var_8_1)

		local var_8_4 = arg_8_0.viewGO.transform.parent.parent.parent
		local var_8_5 = arg_8_0:checkItemInGoodsList(var_8_4, var_8_0)

		recthelper.setAnchorX(var_8_0, 0)

		arg_8_0._mask.enabled = not var_8_3 or not var_8_5
	end
end

function var_0_0._onDraggingEnd(arg_9_0)
	if arg_9_0:_isUniqueSkin() and arg_9_0._skinSpineGO2 then
		local var_9_0 = arg_9_0.viewGO.transform
		local var_9_1 = recthelper.getWidth(var_9_0) * 0.5

		recthelper.setAnchorX(var_9_0, -var_9_1)

		local var_9_2 = arg_9_0.viewGO.transform.parent.parent.parent
		local var_9_3 = arg_9_0:checkItemInGoodsList(var_9_2, var_9_0)

		recthelper.setAnchorX(var_9_0, var_9_1)

		local var_9_4 = arg_9_0.viewGO.transform.parent.parent.parent
		local var_9_5 = arg_9_0:checkItemInGoodsList(var_9_4, var_9_0)

		recthelper.setAnchorX(var_9_0, 0)

		arg_9_0._mask.enabled = not var_9_3 or not var_9_5
	end
end

function var_0_0.checkItemInGoodsList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0, var_10_1 = recthelper.uiPosToScreenPos2(arg_10_2)

	return recthelper.screenPosInRect(arg_10_1, CameraMgr.instance:getUICamera(), var_10_0, var_10_1)
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0._mo = arg_11_1

	local var_11_0 = arg_11_0:_isLinkageSkin()
	local var_11_1 = not var_11_0 and arg_11_0:_isNormalSkin()
	local var_11_2 = not var_11_0 and arg_11_0:_isAdvanceSkin()
	local var_11_3 = not var_11_0 and arg_11_0:_isUniqueSkin()
	local var_11_4 = var_0_5
	local var_11_5 = arg_11_0._mo.config.product
	local var_11_6 = string.splitToNumber(var_11_5, "#")[2]

	arg_11_0._skinId = var_11_6
	arg_11_0.skinCo = SkinConfig.instance:getSkinCo(var_11_6)

	local var_11_7 = HeroConfig.instance:getHeroCO(arg_11_0.skinCo.characterId)

	arg_11_0:clearSpine()
	gohelper.setActive(arg_11_0._goNormalSkin, var_11_1)
	gohelper.setActive(arg_11_0._goAdvanceSkin, var_11_2)
	gohelper.setActive(arg_11_0._goUniqueSkin, var_11_3)
	gohelper.setActive(arg_11_0._goLinkage, var_11_0)
	gohelper.setActive(arg_11_0._goLinkageLogo, arg_11_0:_isShowLinkageLogo())

	if var_11_3 then
		var_11_4 = arg_11_0:_onUpdateMO_uniqueSkin()
	else
		local var_11_8

		if var_11_0 then
			var_11_8 = arg_11_0._linkage_simageicon

			gohelper.setActive(arg_11_0._goLinkageBgA, arg_11_0:_isAdvanceSkin())
			gohelper.setActive(arg_11_0._goLinkageBgG, arg_11_0:_isNormalSkin())
			gohelper.setActive(arg_11_0._goLinkageLetterA, arg_11_0:_isAdvanceSkin())
			gohelper.setActive(arg_11_0._goLinkageLetterG, arg_11_0:_isNormalSkin())
		elseif var_11_2 then
			var_11_8 = arg_11_0._advanceImageicon
		else
			var_11_8 = arg_11_0._simageicon
		end

		if string.nilorempty(arg_11_0._mo.config.bigImg) == false then
			var_11_8:LoadImage(arg_11_0._mo.config.bigImg)
		else
			var_11_8:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	arg_11_0._simagesign:LoadImage(var_11_4, arg_11_0._loadedSignImage, arg_11_0)

	if var_11_3 then
		recthelper.setWidth(arg_11_0._txtskinname.transform, 215)
	else
		recthelper.setWidth(arg_11_0._txtskinname.transform, 352)
	end

	arg_11_0._txtskinname.text = arg_11_0.skinCo.characterSkin
	arg_11_0._txtname.text = var_11_7.name

	local var_11_9 = arg_11_1:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_11_1)

	if var_11_9 then
		gohelper.setActive(arg_11_0._goowned, true)
		gohelper.setActive(arg_11_0._goprice, false)
		gohelper.setActive(arg_11_0._godeduction, false)
	else
		gohelper.setActive(arg_11_0._goowned, false)
		gohelper.setActive(arg_11_0._goprice, true)

		local var_11_10 = 0

		if not string.nilorempty(arg_11_0._mo.config.deductionItem) then
			local var_11_11 = GameUtil.splitString2(arg_11_0._mo.config.deductionItem, true)

			var_11_10 = ItemModel.instance:getItemCount(var_11_11[1][2])
			arg_11_0._txtdeduction.text = -var_11_11[2][1]
		end

		gohelper.setActive(arg_11_0._godeduction, var_11_10 > 0)
	end

	local var_11_12 = string.splitToNumber(arg_11_0._mo.config.cost, "#")

	arg_11_0._costType = var_11_12[1]
	arg_11_0._costId = var_11_12[2]
	arg_11_0._costQuantity = var_11_12[3]

	local var_11_13, var_11_14 = ItemModel.instance:getItemConfigAndIcon(arg_11_0._costType, arg_11_0._costId)
	local var_11_15 = var_11_13.icon
	local var_11_16 = string.format("%s_1", var_11_15)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_11_0._simagematerial, var_11_16, true)

	arg_11_0._txtmaterialNum.text = arg_11_0._costQuantity

	gohelper.setActive(arg_11_0._gotag, arg_11_1.config.originalCost > 0)
	gohelper.setActive(arg_11_0._txtoriginalprice.gameObject, arg_11_1.config.originalCost > 0)

	local var_11_17 = arg_11_0._costQuantity / arg_11_1.config.originalCost
	local var_11_18 = math.ceil(var_11_17 * 100)

	arg_11_0._txtdiscount.text = string.format("-%d%%", 100 - var_11_18)
	arg_11_0._txtoriginalprice.text = arg_11_1.config.originalCost

	gohelper.setActive(arg_11_0._gonewtag, arg_11_1:needShowNew())

	local var_11_19 = arg_11_1:getOfflineTime()
	local var_11_20 = var_11_19 - ServerTime.now()

	gohelper.setActive(arg_11_0._goremaintime, var_11_19 > 0 and var_11_9 == false)

	if var_11_20 > 3600 then
		local var_11_21, var_11_22 = TimeUtil.secondToRoughTime(var_11_20)

		arg_11_0._txtremaintime.text = formatLuaLang("remain", var_11_21 .. var_11_22)
	else
		arg_11_0._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	arg_11_0:refreshChargeInfo()
	arg_11_0:refreshSkinTips()

	if arg_11_0._view and arg_11_0._view.viewContainer then
		arg_11_0._view.viewContainer:dispatchEvent(StoreEvent.SkinGoodsItemChanged)
	end
end

function var_0_0.refreshChargeInfo(arg_12_0)
	local var_12_0
	local var_12_1

	if arg_12_0.skinCo then
		local var_12_2 = arg_12_0.skinCo.id

		if StoreModel.instance:isStoreSkinChargePackageValid(var_12_2) then
			var_12_0, var_12_1 = StoreConfig.instance:getSkinChargePrice(var_12_2)
		end
	end

	if var_12_0 then
		local var_12_3 = string.format("%s%s", StoreModel.instance:getCostStr(var_12_0))

		arg_12_0._txtCharge.text = var_12_3

		if var_12_1 then
			arg_12_0._txtOriginalCharge.text = var_12_1
		end

		gohelper.setActive(arg_12_0._txtOriginalCharge.gameObject, var_12_1)
	end

	local var_12_4 = false

	if arg_12_0._mo then
		var_12_4 = arg_12_0._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_12_0._mo)
	end

	gohelper.setActive(arg_12_0._goCharge, var_12_0 and not var_12_4)
	ZProj.UGUIHelper.RebuildLayout(arg_12_0._goCharge.transform)
end

function var_0_0._onSkinSpineLoaded(arg_13_0)
	local var_13_0 = arg_13_0._skinSpine:getSpineTr()
	local var_13_1 = var_13_0.parent

	recthelper.setWidth(var_13_0, recthelper.getWidth(var_13_1))
	recthelper.setHeight(var_13_0, recthelper.getHeight(var_13_1))
	arg_13_0:setSpineRaycastTarget(arg_13_0._raycastTarget)
end

function var_0_0._onSkinSpine2Loaded(arg_14_0)
	local var_14_0 = arg_14_0._skinSpine2:getSpineTr()
	local var_14_1 = var_14_0.parent

	recthelper.setWidth(var_14_0, recthelper.getWidth(var_14_1))
	recthelper.setHeight(var_14_0, recthelper.getHeight(var_14_1))
end

function var_0_0._onSpineLoaded(arg_15_0)
	local var_15_0 = 0
	local var_15_1 = 0
	local var_15_2 = 1
	local var_15_3 = arg_15_0._skinSpine:getSpineTr()
	local var_15_4 = arg_15_0._uniqueImageicon.transform

	recthelper.setAnchor(var_15_3, recthelper.getAnchor(var_15_4))
	recthelper.setWidth(var_15_3, recthelper.getWidth(var_15_4))
	recthelper.setHeight(var_15_3, recthelper.getHeight(var_15_4))
	recthelper.setAnchor(var_15_3, var_15_0, var_15_1)
	transformhelper.setLocalScale(var_15_3, var_15_2, var_15_2, 1)
	arg_15_0:setSpineRaycastTarget(arg_15_0._raycastTarget)
end

function var_0_0._loadedSignImage(arg_16_0)
	gohelper.onceAddComponent(arg_16_0._simagesign.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0.setSpineRaycastTarget(arg_17_0, arg_17_1)
	arg_17_0._raycastTarget = arg_17_1 == true and true or false

	if arg_17_0._skinSpine then
		local var_17_0 = arg_17_0._skinSpine:getSkeletonGraphic()

		if var_17_0 then
			var_17_0.raycastTarget = arg_17_0._raycastTarget
		end
	end
end

function var_0_0.onSelect(arg_18_0, arg_18_1)
	return
end

function var_0_0.getAnimator(arg_19_0)
	return arg_19_0._animator
end

function var_0_0.refreshSkinTips(arg_20_0)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_20_0._mo) then
		gohelper.setActive(arg_20_0._goSkinTips, true)

		local var_20_0 = string.splitToNumber(arg_20_0.skinCo.compensate, "#")
		local var_20_1 = var_20_0[2]
		local var_20_2 = var_20_0[3]
		local var_20_3 = CurrencyConfig.instance:getCurrencyCo(var_20_1)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0._imgProp, string.format("%s_1", var_20_3.icon))

		arg_20_0._txtPropNum.text = tostring(var_20_2)
	else
		gohelper.setActive(arg_20_0._goSkinTips, false)
	end
end

function var_0_0.clearSpine(arg_21_0)
	GameUtil.doClearMember(arg_21_0, "_skinSpine")
	GameUtil.doClearMember(arg_21_0, "_skinSpine2")
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0._btn:RemoveClickListener()
	arg_22_0._simagebg:UnLoadImage()
	arg_22_0._simageg:UnLoadImage()
	arg_22_0._simagesign:UnLoadImage()
	arg_22_0._simagesign:UnLoadImage()
	arg_22_0._uniqueSingleImageicon:UnLoadImage()
	arg_22_0._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(arg_22_0, "_skinSpine")
	GameUtil.doClearMember(arg_22_0, "_skinSpine2")

	if arg_22_0:_isUniqueSkin() then
		arg_22_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_22_0._onDraggingBegin, arg_22_0)
		arg_22_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_22_0._onDraggingEnd, arg_22_0)
		arg_22_0:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_22_0._onDragging, arg_22_0)
	end
end

function var_0_0._onUpdateMO_uniqueSkin(arg_23_0)
	local var_23_0 = var_0_5

	arg_23_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_23_0._onDraggingBegin, arg_23_0)
	arg_23_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_23_0._onDraggingEnd, arg_23_0)
	arg_23_0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_23_0._onDragging, arg_23_0)

	local var_23_1 = arg_23_0._mo.config.bigImg
	local var_23_2 = arg_23_0._mo.config.spineParams

	if not string.nilorempty(var_23_2) then
		local var_23_3 = string.split(var_23_2, "#")
		local var_23_4 = #var_23_3
		local var_23_5 = var_23_3[1]
		local var_23_6 = var_23_4 > 1 and var_23_3[2]
		local var_23_7 = var_23_4 > 2 and string.splitToNumber(var_23_3[3], ",")
		local var_23_8 = var_23_4 > 3 and tonumber(var_23_3[4])
		local var_23_9 = var_23_4 > 4 and var_23_3[5]

		var_23_0 = var_23_4 > 6 and var_23_3[7] or var_23_0

		if arg_23_0._skinSpine then
			arg_23_0._skinSpine:setResPath(var_23_5, arg_23_0._onSkinSpineLoaded, arg_23_0, true)
		else
			arg_23_0._skinSpineGO = arg_23_0._skinSpineGO or gohelper.create2d(arg_23_0._goUniqueSkinsImage, "uniqueSkinSpine")

			local var_23_10 = arg_23_0._skinSpineGO.transform

			recthelper.setWidth(var_23_10, var_0_4[1])
			transformhelper.setLocalPos(var_23_10, var_23_7[1], var_23_7[2], 0)
			transformhelper.setLocalScale(var_23_10, var_23_8, var_23_8, var_23_8)

			arg_23_0._skinSpine = GuiSpine.Create(arg_23_0._skinSpineGO, false)

			arg_23_0._skinSpine:setResPath(var_23_5, arg_23_0._onSkinSpineLoaded, arg_23_0, true)

			if not string.nilorempty(var_23_6) then
				arg_23_0._skinSpineGO2 = arg_23_0._skinSpineGO2 or gohelper.create2d(arg_23_0._goUniqueImageicon2, "uniqueSkinSpine2")

				local var_23_11 = arg_23_0._skinSpineGO2.transform

				recthelper.setWidth(var_23_11, var_0_4[1])
				transformhelper.setLocalPos(var_23_11, var_23_7[1], var_23_7[2], 0)
				transformhelper.setLocalScale(var_23_11, var_23_8, var_23_8, var_23_8)

				arg_23_0._skinSpine2 = GuiSpine.Create(arg_23_0._skinSpineGO2, false)

				arg_23_0._skinSpine2:setResPath(var_23_6, arg_23_0._onSkinSpine2Loaded, arg_23_0, true)
			end

			transformhelper.setLocalPos(arg_23_0._uniqueImageicon.transform, 0, 0, 0)

			arg_23_0._uniqueImageicon.transform.sizeDelta = Vector2.New(var_0_3[1], var_0_3[2])
		end

		gohelper.setActive(arg_23_0._skinSpineGO, true)
		gohelper.setActive(arg_23_0._goUniqueSkinBubble, false)
		gohelper.setActive(arg_23_0._govx_iconbg, false)
		gohelper.setActive(arg_23_0._govx_bg, false)

		if not string.nilorempty(var_23_9) then
			arg_23_0._uniqueImagebg:LoadImage(var_23_9)

			arg_23_0._uniqueImageicon.enabled = true

			arg_23_0._uniqueSingleImageicon:LoadImage(var_23_9)
		else
			gohelper.setActive(arg_23_0._uniqueImagebg.gameObject, false)

			arg_23_0._uniqueImageicon.enabled = false
		end
	elseif string.find(var_23_1, "prefab") then
		local var_23_12 = string.split(var_23_1, "#")
		local var_23_13 = #var_23_12
		local var_23_14 = var_23_12[1]
		local var_23_15 = var_23_12[2]

		var_23_0 = var_23_13 > 3 and var_23_12[4] or var_23_0

		if arg_23_0._skinSpine then
			arg_23_0._skinSpine:setResPath(var_23_14, arg_23_0._onSpineLoaded, arg_23_0, true)
		else
			arg_23_0._skinSpineGO = arg_23_0._skinSpineGO or gohelper.create2d(arg_23_0._goUniqueSkinsImage, "uniqueSkinSpine")

			transformhelper.setLocalPos(arg_23_0._skinSpineGO.transform, var_0_1[1], var_0_1[2], var_0_1[3])

			arg_23_0._skinSpine = GuiSpine.Create(arg_23_0._skinSpineGO, false)

			arg_23_0._skinSpine:setResPath(var_23_14, arg_23_0._onSpineLoaded, arg_23_0, true)
		end

		gohelper.setActive(arg_23_0._skinSpineGO, true)

		if not string.nilorempty(var_23_15) then
			arg_23_0._uniqueImagebg:LoadImage(var_23_15)
		else
			arg_23_0._uniqueImagebg:LoadImage(var_0_2)
		end

		arg_23_0._uniqueImageicon.enabled = true
	else
		arg_23_0._uniqueImageicon.enabled = true

		if not string.nilorempty(var_23_1) then
			arg_23_0._uniqueSingleImageicon:LoadImage(arg_23_0._mo.config.bigImg)
		else
			arg_23_0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	return var_23_0
end

function var_0_0._isNormalSkin(arg_24_0)
	return arg_24_0._mo.config.skinLevel == 0
end

function var_0_0._isAdvanceSkin(arg_25_0)
	return arg_25_0._mo.config.isAdvancedSkin or arg_25_0._mo.config.skinLevel == 1
end

function var_0_0._isUniqueSkin(arg_26_0)
	return arg_26_0._mo.config.skinLevel == 2
end

function var_0_0._isLinkageSkin(arg_27_0)
	return arg_27_0._mo.config.islinkageSkin or false
end

function var_0_0._isShowLinkageLogo(arg_28_0)
	return arg_28_0._mo.config.showLinkageLogo or false
end

return var_0_0
