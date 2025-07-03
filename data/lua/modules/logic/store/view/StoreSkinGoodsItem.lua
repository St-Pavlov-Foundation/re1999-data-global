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
	arg_4_0._linkage_simageicon = gohelper.findChildSingleImage(arg_4_0._goLinkage, "#simage_icon")
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO, AudioEnum.UI.play_ui_rolesopen)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._mask.enabled = false
end

function var_0_0._onClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = arg_5_0._mo
	})
end

function var_0_0._onDraggingBegin(arg_6_0)
	if arg_6_0:_isUniqueSkin() and arg_6_0._skinSpineGO2 then
		arg_6_0._mask.enabled = true
	end
end

function var_0_0._onDragging(arg_7_0)
	if arg_7_0:_isUniqueSkin() and arg_7_0._skinSpineGO2 then
		local var_7_0 = arg_7_0.viewGO.transform
		local var_7_1 = recthelper.getWidth(var_7_0) * 0.5

		recthelper.setAnchorX(var_7_0, -var_7_1)

		local var_7_2 = arg_7_0.viewGO.transform.parent.parent.parent
		local var_7_3 = arg_7_0:checkItemInGoodsList(var_7_2, var_7_0)

		recthelper.setAnchorX(var_7_0, var_7_1)

		local var_7_4 = arg_7_0.viewGO.transform.parent.parent.parent
		local var_7_5 = arg_7_0:checkItemInGoodsList(var_7_4, var_7_0)

		recthelper.setAnchorX(var_7_0, 0)

		arg_7_0._mask.enabled = not var_7_3 or not var_7_5
	end
end

function var_0_0._onDraggingEnd(arg_8_0)
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

function var_0_0.checkItemInGoodsList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0, var_9_1 = recthelper.uiPosToScreenPos2(arg_9_2)

	return recthelper.screenPosInRect(arg_9_1, CameraMgr.instance:getUICamera(), var_9_0, var_9_1)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = arg_10_0:_isLinkageSkin()
	local var_10_1 = not var_10_0 and arg_10_0:_isNormalSkin()
	local var_10_2 = not var_10_0 and arg_10_0:_isAdvanceSkin()
	local var_10_3 = not var_10_0 and arg_10_0:_isUniqueSkin()
	local var_10_4 = var_0_5
	local var_10_5 = arg_10_0._mo.config.product
	local var_10_6 = string.splitToNumber(var_10_5, "#")[2]

	arg_10_0.skinCo = SkinConfig.instance:getSkinCo(var_10_6)

	local var_10_7 = HeroConfig.instance:getHeroCO(arg_10_0.skinCo.characterId)

	arg_10_0:clearSpine()
	gohelper.setActive(arg_10_0._goNormalSkin, var_10_1)
	gohelper.setActive(arg_10_0._goAdvanceSkin, var_10_2)
	gohelper.setActive(arg_10_0._goUniqueSkin, var_10_3)
	gohelper.setActive(arg_10_0._goLinkage, var_10_0)

	if var_10_3 then
		arg_10_0:_onUpdateMO_uniqueSkin()
	else
		local var_10_8

		if var_10_0 then
			var_10_8 = arg_10_0._linkage_simageicon

			gohelper.setActive(arg_10_0._goLinkageBgA, arg_10_0:_isAdvanceSkin())
			gohelper.setActive(arg_10_0._goLinkageBgG, arg_10_0:_isNormalSkin())
			gohelper.setActive(arg_10_0._goLinkageLetterA, arg_10_0:_isAdvanceSkin())
			gohelper.setActive(arg_10_0._goLinkageLetterG, arg_10_0:_isNormalSkin())
		elseif var_10_2 then
			var_10_8 = arg_10_0._advanceImageicon
		else
			var_10_8 = arg_10_0._simageicon
		end

		if string.nilorempty(arg_10_0._mo.config.bigImg) == false then
			var_10_8:LoadImage(arg_10_0._mo.config.bigImg)
		else
			var_10_8:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	arg_10_0._simagesign:LoadImage(var_10_4, arg_10_0._loadedSignImage, arg_10_0)

	arg_10_0._txtskinname.text = arg_10_0.skinCo.characterSkin
	arg_10_0._txtname.text = var_10_7.name

	local var_10_9 = arg_10_1:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_10_1)

	if var_10_9 then
		gohelper.setActive(arg_10_0._goowned, true)
		gohelper.setActive(arg_10_0._goprice, false)
		gohelper.setActive(arg_10_0._godeduction, false)
	else
		gohelper.setActive(arg_10_0._goowned, false)
		gohelper.setActive(arg_10_0._goprice, true)

		local var_10_10 = 0

		if not string.nilorempty(arg_10_0._mo.config.deductionItem) then
			local var_10_11 = GameUtil.splitString2(arg_10_0._mo.config.deductionItem, true)

			var_10_10 = ItemModel.instance:getItemCount(var_10_11[1][2])
			arg_10_0._txtdeduction.text = -var_10_11[2][1]
		end

		gohelper.setActive(arg_10_0._godeduction, var_10_10 > 0)
	end

	local var_10_12 = string.splitToNumber(arg_10_0._mo.config.cost, "#")

	arg_10_0._costType = var_10_12[1]
	arg_10_0._costId = var_10_12[2]
	arg_10_0._costQuantity = var_10_12[3]

	local var_10_13, var_10_14 = ItemModel.instance:getItemConfigAndIcon(arg_10_0._costType, arg_10_0._costId)
	local var_10_15 = var_10_13.icon
	local var_10_16 = string.format("%s_1", var_10_15)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_10_0._simagematerial, var_10_16, true)

	arg_10_0._txtmaterialNum.text = arg_10_0._costQuantity

	gohelper.setActive(arg_10_0._gotag, arg_10_1.config.originalCost > 0)
	gohelper.setActive(arg_10_0._txtoriginalprice.gameObject, arg_10_1.config.originalCost > 0)

	local var_10_17 = arg_10_0._costQuantity / arg_10_1.config.originalCost
	local var_10_18 = math.ceil(var_10_17 * 100)

	arg_10_0._txtdiscount.text = string.format("-%d%%", 100 - var_10_18)
	arg_10_0._txtoriginalprice.text = arg_10_1.config.originalCost

	gohelper.setActive(arg_10_0._gonewtag, arg_10_1:needShowNew())

	local var_10_19 = arg_10_1:getOfflineTime()
	local var_10_20 = var_10_19 - ServerTime.now()

	gohelper.setActive(arg_10_0._goremaintime, var_10_19 > 0 and var_10_9 == false)

	if var_10_20 > 3600 then
		local var_10_21, var_10_22 = TimeUtil.secondToRoughTime(var_10_20)

		arg_10_0._txtremaintime.text = formatLuaLang("remain", var_10_21 .. var_10_22)
	else
		arg_10_0._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	arg_10_0:refreshChargeInfo()
	arg_10_0:refreshSkinTips()
end

function var_0_0.refreshChargeInfo(arg_11_0)
	local var_11_0
	local var_11_1

	if arg_11_0.skinCo then
		local var_11_2 = arg_11_0.skinCo.id

		if StoreModel.instance:isStoreSkinChargePackageValid(var_11_2) then
			var_11_0, var_11_1 = StoreConfig.instance:getSkinChargePrice(var_11_2)
		end
	end

	if var_11_0 then
		local var_11_3 = string.format("%s%s", StoreModel.instance:getCostStr(var_11_0))

		arg_11_0._txtCharge.text = var_11_3

		if var_11_1 then
			arg_11_0._txtOriginalCharge.text = var_11_1
		end

		gohelper.setActive(arg_11_0._txtOriginalCharge.gameObject, var_11_1)
	end

	local var_11_4 = false

	if arg_11_0._mo then
		var_11_4 = arg_11_0._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_11_0._mo)
	end

	gohelper.setActive(arg_11_0._goCharge, var_11_0 and not var_11_4)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0._goCharge.transform)
end

function var_0_0._onSkinSpineLoaded(arg_12_0)
	local var_12_0 = arg_12_0._skinSpine:getSpineTr()
	local var_12_1 = var_12_0.parent

	recthelper.setWidth(var_12_0, recthelper.getWidth(var_12_1))
	recthelper.setHeight(var_12_0, recthelper.getHeight(var_12_1))
	arg_12_0:setSpineRaycastTarget(arg_12_0._raycastTarget)
end

function var_0_0._onSkinSpine2Loaded(arg_13_0)
	local var_13_0 = arg_13_0._skinSpine2:getSpineTr()
	local var_13_1 = var_13_0.parent

	recthelper.setWidth(var_13_0, recthelper.getWidth(var_13_1))
	recthelper.setHeight(var_13_0, recthelper.getHeight(var_13_1))
end

function var_0_0._onSpineLoaded(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 1
	local var_14_3 = arg_14_0._skinSpine:getSpineTr()
	local var_14_4 = arg_14_0._uniqueImageicon.transform

	recthelper.setAnchor(var_14_3, recthelper.getAnchor(var_14_4))
	recthelper.setWidth(var_14_3, recthelper.getWidth(var_14_4))
	recthelper.setHeight(var_14_3, recthelper.getHeight(var_14_4))
	recthelper.setAnchor(var_14_3, var_14_0, var_14_1)
	transformhelper.setLocalScale(var_14_3, var_14_2, var_14_2, 1)
	arg_14_0:setSpineRaycastTarget(arg_14_0._raycastTarget)
end

function var_0_0._loadedSignImage(arg_15_0)
	gohelper.onceAddComponent(arg_15_0._simagesign.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0.setSpineRaycastTarget(arg_16_0, arg_16_1)
	arg_16_0._raycastTarget = arg_16_1 == true and true or false

	if arg_16_0._skinSpine then
		local var_16_0 = arg_16_0._skinSpine:getSkeletonGraphic()

		if var_16_0 then
			var_16_0.raycastTarget = arg_16_0._raycastTarget
		end
	end
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	return
end

function var_0_0.getAnimator(arg_18_0)
	return arg_18_0._animator
end

function var_0_0.refreshSkinTips(arg_19_0)
	if StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_19_0._mo) then
		gohelper.setActive(arg_19_0._goSkinTips, true)

		local var_19_0 = string.splitToNumber(arg_19_0.skinCo.compensate, "#")
		local var_19_1 = var_19_0[2]
		local var_19_2 = var_19_0[3]
		local var_19_3 = CurrencyConfig.instance:getCurrencyCo(var_19_1)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imgProp, string.format("%s_1", var_19_3.icon))

		arg_19_0._txtPropNum.text = tostring(var_19_2)
	else
		gohelper.setActive(arg_19_0._goSkinTips, false)
	end
end

function var_0_0.clearSpine(arg_20_0)
	GameUtil.doClearMember(arg_20_0, "_skinSpine")
	GameUtil.doClearMember(arg_20_0, "_skinSpine2")
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._btn:RemoveClickListener()
	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simageg:UnLoadImage()
	arg_21_0._simagesign:UnLoadImage()
	arg_21_0._simagesign:UnLoadImage()
	arg_21_0._uniqueSingleImageicon:UnLoadImage()
	arg_21_0._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(arg_21_0, "_skinSpine")
	GameUtil.doClearMember(arg_21_0, "_skinSpine2")

	if arg_21_0:_isUniqueSkin() then
		arg_21_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_21_0._onDraggingBegin, arg_21_0)
		arg_21_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_21_0._onDraggingEnd, arg_21_0)
		arg_21_0:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_21_0._onDragging, arg_21_0)
	end
end

function var_0_0._onUpdateMO_uniqueSkin(arg_22_0)
	local var_22_0 = var_0_5

	arg_22_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_22_0._onDraggingBegin, arg_22_0)
	arg_22_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_22_0._onDraggingEnd, arg_22_0)
	arg_22_0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_22_0._onDragging, arg_22_0)
	gohelper.setAsLastSibling(arg_22_0.viewGO.transform.parent.gameObject)

	local var_22_1 = arg_22_0._mo.config.bigImg
	local var_22_2 = arg_22_0._mo.config.spineParams

	if not string.nilorempty(var_22_2) then
		local var_22_3 = string.split(var_22_2, "#")
		local var_22_4 = #var_22_3
		local var_22_5 = var_22_3[1]
		local var_22_6 = var_22_4 > 1 and var_22_3[2]
		local var_22_7 = var_22_4 > 2 and string.splitToNumber(var_22_3[3], ",")
		local var_22_8 = var_22_4 > 3 and tonumber(var_22_3[4])
		local var_22_9 = var_22_4 > 4 and var_22_3[5]
		local var_22_10

		var_22_10 = var_22_4 > 6 and var_22_3[7] or var_22_10

		if arg_22_0._skinSpine then
			arg_22_0._skinSpine:setResPath(var_22_5, arg_22_0._onSkinSpineLoaded, arg_22_0, true)
		else
			arg_22_0._skinSpineGO = arg_22_0._skinSpineGO or gohelper.create2d(arg_22_0._goUniqueSkinsImage, "uniqueSkinSpine")

			local var_22_11 = arg_22_0._skinSpineGO.transform

			recthelper.setWidth(var_22_11, var_0_4[1])
			transformhelper.setLocalPos(var_22_11, var_22_7[1], var_22_7[2], 0)
			transformhelper.setLocalScale(var_22_11, var_22_8, var_22_8, var_22_8)

			arg_22_0._skinSpine = GuiSpine.Create(arg_22_0._skinSpineGO, false)

			arg_22_0._skinSpine:setResPath(var_22_5, arg_22_0._onSkinSpineLoaded, arg_22_0, true)

			if not string.nilorempty(var_22_6) then
				arg_22_0._skinSpineGO2 = arg_22_0._skinSpineGO2 or gohelper.create2d(arg_22_0._goUniqueImageicon2, "uniqueSkinSpine2")

				local var_22_12 = arg_22_0._skinSpineGO2.transform

				recthelper.setWidth(var_22_12, var_0_4[1])
				transformhelper.setLocalPos(var_22_12, var_22_7[1], var_22_7[2], 0)
				transformhelper.setLocalScale(var_22_12, var_22_8, var_22_8, var_22_8)

				arg_22_0._skinSpine2 = GuiSpine.Create(arg_22_0._skinSpineGO2, false)

				arg_22_0._skinSpine2:setResPath(var_22_6, arg_22_0._onSkinSpine2Loaded, arg_22_0, true)
			end

			transformhelper.setLocalPos(arg_22_0._uniqueImageicon.transform, 0, 0, 0)

			arg_22_0._uniqueImageicon.transform.sizeDelta = Vector2.New(var_0_3[1], var_0_3[2])
		end

		gohelper.setActive(arg_22_0._skinSpineGO, true)
		gohelper.setActive(arg_22_0._goUniqueSkinBubble, false)
		gohelper.setActive(arg_22_0._govx_iconbg, false)
		gohelper.setActive(arg_22_0._govx_bg, false)

		if not string.nilorempty(var_22_9) then
			arg_22_0._uniqueImagebg:LoadImage(var_22_9)

			arg_22_0._uniqueImageicon.enabled = true

			arg_22_0._uniqueSingleImageicon:LoadImage(var_22_9)
		else
			gohelper.setActive(arg_22_0._uniqueImagebg.gameObject, false)

			arg_22_0._uniqueImageicon.enabled = false
		end
	elseif string.find(var_22_1, "prefab") then
		local var_22_13 = string.split(var_22_1, "#")
		local var_22_14 = #var_22_13
		local var_22_15 = var_22_13[1]
		local var_22_16 = var_22_13[2]
		local var_22_17

		var_22_17 = var_22_14 > 3 and var_22_13[4] or var_22_17

		if arg_22_0._skinSpine then
			arg_22_0._skinSpine:setResPath(var_22_15, arg_22_0._onSpineLoaded, arg_22_0, true)
		else
			arg_22_0._skinSpineGO = arg_22_0._skinSpineGO or gohelper.create2d(arg_22_0._goUniqueSkinsImage, "uniqueSkinSpine")

			transformhelper.setLocalPos(arg_22_0._skinSpineGO.transform, var_0_1[1], var_0_1[2], var_0_1[3])

			arg_22_0._skinSpine = GuiSpine.Create(arg_22_0._skinSpineGO, false)

			arg_22_0._skinSpine:setResPath(var_22_15, arg_22_0._onSpineLoaded, arg_22_0, true)
		end

		gohelper.setActive(arg_22_0._skinSpineGO, true)

		if not string.nilorempty(var_22_16) then
			arg_22_0._uniqueImagebg:LoadImage(var_22_16)
		else
			arg_22_0._uniqueImagebg:LoadImage(var_0_2)
		end

		arg_22_0._uniqueImageicon.enabled = true
	else
		arg_22_0._uniqueImageicon.enabled = true

		if not string.nilorempty(var_22_1) then
			arg_22_0._uniqueSingleImageicon:LoadImage(arg_22_0._mo.config.bigImg)
		else
			arg_22_0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end
end

function var_0_0._isNormalSkin(arg_23_0)
	return arg_23_0._mo.config.skinLevel == 0
end

function var_0_0._isAdvanceSkin(arg_24_0)
	return arg_24_0._mo.config.isAdvancedSkin or arg_24_0._mo.config.skinLevel == 1
end

function var_0_0._isUniqueSkin(arg_25_0)
	return arg_25_0._mo.config.skinLevel == 2
end

function var_0_0._isLinkageSkin(arg_26_0)
	return arg_26_0._mo.config.islinkageSkin or false
end

return var_0_0
