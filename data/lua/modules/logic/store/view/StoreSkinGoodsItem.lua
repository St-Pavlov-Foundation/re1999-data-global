module("modules.logic.store.view.StoreSkinGoodsItem", package.seeall)

local var_0_0 = class("StoreSkinGoodsItem", ListScrollCellExtend)
local var_0_1 = {
	30,
	15,
	0
}
local var_0_2 = "singlebg/characterskin/bg_beijing.png"
local var_0_3 = {
	260,
	600
}
local var_0_4 = "singlebg/signature/color/img_dressing1.png"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NormalSkin/image_bg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_NormalSkin/#simage_icon")
	arg_1_0._goNormalSkin = gohelper.findChild(arg_1_0.viewGO, "#go_NormalSkin")
	arg_1_0._advanceImagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#simage_bg")
	arg_1_0._advanceImageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#simage_icon")
	arg_1_0._advanceImage1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#image_D")
	arg_1_0._advanceImage2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_AdvancedSkin/#image_A")
	arg_1_0._goAdvanceSkin = gohelper.findChild(arg_1_0.viewGO, "#go_AdvancedSkin")
	arg_1_0._goUniqueSkinsImage = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon")
	arg_1_0._goUniqueSkin = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin")
	arg_1_0._uniqueSingleImageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UniqueSkin/#simage_icon")
	arg_1_0._uniqueImagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_UniqueSkin/#simage_iconbg")
	arg_1_0._goUniqueSkinBubble = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#simage_bubble")
	arg_1_0._xtIconbg = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin/#xingti_iconbg")
	arg_1_0._goLinkageLetterG = gohelper.findChild(arg_1_0.viewGO, "#go_Linkage/#simage_g")
	arg_1_0._goLinkageLetterA = gohelper.findChild(arg_1_0.viewGO, "#go_Linkage/#image_A")
	arg_1_0._goLinkageBgG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Linkage/#simage_bg")
	arg_1_0._goLinkageBgA = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Linkage/#simage_bgA")
	arg_1_0._gocostline = gohelper.findChild(arg_1_0.viewGO, "cost/line")
	arg_1_0._goprice = gohelper.findChild(arg_1_0.viewGO, "cost/#go_price")
	arg_1_0._goowned = gohelper.findChild(arg_1_0.viewGO, "cost/#go_owned")
	arg_1_0._txtoriginalprice = gohelper.findChildText(arg_1_0.viewGO, "cost/#txt_original_price")
	arg_1_0._goCharge = gohelper.findChild(arg_1_0.viewGO, "cost/#go_charge")
	arg_1_0._txtCharge = gohelper.findChildText(arg_1_0.viewGO, "cost/#go_charge/txt_chargeNum")
	arg_1_0._txtOriginalCharge = gohelper.findChildText(arg_1_0.viewGO, "cost/#go_charge/txt_originalChargeNum")
	arg_1_0._goremaintime = gohelper.findChild(arg_1_0.viewGO, "#go_tag/#go_remaintime")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "#go_tag/#go_remaintime/bg/icon/#txt_remaintime")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "#go_tag")
	arg_1_0._gonewtag = gohelper.findChild(arg_1_0.viewGO, "#go_newtag")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "#go_tag/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "#go_tag/#go_discount/#txt_discount")
	arg_1_0._godeduction = gohelper.findChild(arg_1_0.viewGO, "#go_tag/#go_deduction")
	arg_1_0._txtdeduction = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_tag/#go_deduction/txt_materialNum")
	arg_1_0._goSkinTips = gohelper.findChild(arg_1_0.viewGO, "#go_SkinTips")
	arg_1_0._imgProp = gohelper.findChildImage(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num/#image_Prop")
	arg_1_0._txtPropNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_SkinTips/image/#txt_Tips/#txt_Num")
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "#go_select")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, arg_2_0.refreshChargeInfo, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, arg_2_0._onSkinPreviewChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.SkinChargePackageUpdate, arg_3_0.refreshChargeInfo, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.SkinPreviewChanged, arg_3_0._onSkinPreviewChanged, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("img_card_bg"))

	arg_4_0._txtmaterialNum = gohelper.findChildText(arg_4_0._goprice, "txt_materialNum")
	arg_4_0._simagematerial = gohelper.findChildImage(arg_4_0._goprice, "simage_material")
	arg_4_0._goLinkage = gohelper.findChild(arg_4_0.viewGO, "#go_Linkage")
	arg_4_0._goLinkageLogo = gohelper.findChild(arg_4_0.viewGO, "#go_Linkage/image_Logo")
	arg_4_0._linkage_simageicon = gohelper.findChildSingleImage(arg_4_0._goLinkage, "#simage_icon")
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO, AudioEnum.UI.play_ui_rolesopen)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0.viewGOTrs = arg_4_0.viewGO.transform
	arg_4_0.parentViewGO = arg_4_0.viewGO.transform.parent.gameObject
end

function var_0_0._onSkinPreviewChanged(arg_5_0)
	arg_5_0:updateSelect()
	arg_5_0:updateNew()
end

function var_0_0.updateNew(arg_6_0)
	local var_6_0 = arg_6_0._mo:checkShowNewRedDot()

	gohelper.setActive(arg_6_0._gonewtag, var_6_0)
end

function var_0_0.updateSelect(arg_7_0)
	local var_7_0 = StoreClothesGoodsItemListModel.instance:getSelectGoods() == arg_7_0._mo

	gohelper.setActive(arg_7_0.goSelect, var_7_0)

	if arg_7_0._mo:checkShowNewRedDot() then
		arg_7_0._mo:setNewRedDotKey()
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0._onClick(arg_8_0)
	StoreClothesGoodsItemListModel.instance:setSelectIndex(arg_8_0._index)
end

function var_0_0._openStoreSkinView(arg_9_0)
	ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
		goodsMO = arg_9_0._mo
	})
end

function var_0_0._onDraggingBegin(arg_10_0)
	return
end

function var_0_0._onDragging(arg_11_0)
	return
end

function var_0_0._onDraggingEnd(arg_12_0)
	return
end

function var_0_0.checkItemInGoodsList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = recthelper.uiPosToScreenPos2(arg_13_2)

	return recthelper.screenPosInRect(arg_13_1, CameraMgr.instance:getUICamera(), var_13_0, var_13_1)
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._mo = arg_14_1

	local var_14_0 = arg_14_0:_isLinkageSkin()
	local var_14_1 = not var_14_0 and arg_14_0:_isNormalSkin()
	local var_14_2 = not var_14_0 and arg_14_0:_isAdvanceSkin()
	local var_14_3 = not var_14_0 and arg_14_0:_isUniqueSkin()
	local var_14_4 = arg_14_0._mo.config.product
	local var_14_5 = string.splitToNumber(var_14_4, "#")[2]

	arg_14_0._skinId = var_14_5
	arg_14_0.skinCo = SkinConfig.instance:getSkinCo(var_14_5)

	local var_14_6 = HeroConfig.instance:getHeroCO(arg_14_0.skinCo.characterId)

	arg_14_0:clearSpine()
	gohelper.setActive(arg_14_0._goNormalSkin, var_14_1)
	gohelper.setActive(arg_14_0._goAdvanceSkin, var_14_2)
	gohelper.setActive(arg_14_0._goUniqueSkin, var_14_3)
	gohelper.setActive(arg_14_0._goLinkage, var_14_0)
	gohelper.setActive(arg_14_0._goLinkageLogo, arg_14_0:_isShowLinkageLogo())

	if var_14_3 then
		arg_14_0:_onUpdateMO_uniqueSkin()
	else
		local var_14_7

		if var_14_0 then
			var_14_7 = arg_14_0._linkage_simageicon

			gohelper.setActive(arg_14_0._goLinkageBgA, arg_14_0:_isAdvanceSkin())
			gohelper.setActive(arg_14_0._goLinkageBgG, arg_14_0:_isNormalSkin())
			gohelper.setActive(arg_14_0._goLinkageLetterA, arg_14_0:_isAdvanceSkin())
			gohelper.setActive(arg_14_0._goLinkageLetterG, arg_14_0:_isNormalSkin())
		elseif var_14_2 then
			var_14_7 = arg_14_0._advanceImageicon
		else
			var_14_7 = arg_14_0._simageicon
		end

		if string.nilorempty(arg_14_0._mo.config.bigImg) == false then
			var_14_7:LoadImage(arg_14_0._mo.config.bigImg)
		else
			var_14_7:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	end

	local var_14_8 = arg_14_1:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_14_1)

	if var_14_8 then
		gohelper.setActive(arg_14_0._goowned, true)
		gohelper.setActive(arg_14_0._goprice, false)
		gohelper.setActive(arg_14_0._godeduction, false)
		gohelper.setActive(arg_14_0._gocostline, false)
	else
		gohelper.setActive(arg_14_0._goowned, false)
		gohelper.setActive(arg_14_0._goprice, true)
		gohelper.setActive(arg_14_0._gocostline, true)

		local var_14_9 = 0

		if not string.nilorempty(arg_14_0._mo.config.deductionItem) then
			local var_14_10 = GameUtil.splitString2(arg_14_0._mo.config.deductionItem, true)

			var_14_9 = ItemModel.instance:getItemCount(var_14_10[1][2])
			arg_14_0._txtdeduction.text = -var_14_10[2][1]
		end

		gohelper.setActive(arg_14_0._godeduction, var_14_9 > 0)
	end

	local var_14_11 = string.splitToNumber(arg_14_0._mo.config.cost, "#")

	arg_14_0._costType = var_14_11[1]
	arg_14_0._costId = var_14_11[2]
	arg_14_0._costQuantity = var_14_11[3]

	local var_14_12, var_14_13 = ItemModel.instance:getItemConfigAndIcon(arg_14_0._costType, arg_14_0._costId)
	local var_14_14 = var_14_12.icon
	local var_14_15 = string.format("%s_1", var_14_14)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_14_0._simagematerial, var_14_15, true)

	arg_14_0._txtmaterialNum.text = arg_14_0._costQuantity

	gohelper.setActive(arg_14_0._godiscount, arg_14_1.config.originalCost > 0)
	gohelper.setActive(arg_14_0._txtoriginalprice.gameObject, arg_14_1.config.originalCost > 0)

	local var_14_16 = arg_14_0._costQuantity / arg_14_1.config.originalCost
	local var_14_17 = math.ceil(var_14_16 * 100)

	arg_14_0._txtdiscount.text = string.format("-%d%%", 100 - var_14_17)
	arg_14_0._txtoriginalprice.text = arg_14_1.config.originalCost

	local var_14_18 = arg_14_1:getOfflineTime()
	local var_14_19 = var_14_18 - ServerTime.now()

	gohelper.setActive(arg_14_0._goremaintime, var_14_18 > 0 and var_14_8 == false)

	if var_14_19 > 3600 then
		arg_14_0._txtremaintime.text = TimeUtil.getFormatTime1(var_14_19)
	else
		arg_14_0._txtremaintime.text = luaLang("not_enough_one_hour")
	end

	arg_14_0:refreshChargeInfo()
	arg_14_0:refreshSkinTips()
	arg_14_0:updateNew()
	arg_14_0:updateSelect()

	if arg_14_0._view and arg_14_0._view.viewContainer then
		arg_14_0._view.viewContainer:dispatchEvent(StoreEvent.SkinGoodsItemChanged)
	end
end

function var_0_0.refreshChargeInfo(arg_15_0)
	local var_15_0
	local var_15_1

	if arg_15_0.skinCo then
		local var_15_2 = arg_15_0.skinCo.id

		if StoreModel.instance:isStoreSkinChargePackageValid(var_15_2) then
			var_15_0, var_15_1 = StoreConfig.instance:getSkinChargePrice(var_15_2)
		end
	end

	if var_15_0 then
		local var_15_3 = string.format("%s%s", StoreModel.instance:getCostStr(var_15_0))

		arg_15_0._txtCharge.text = var_15_3

		if var_15_1 then
			arg_15_0._txtOriginalCharge.text = var_15_1
		end

		gohelper.setActive(arg_15_0._txtOriginalCharge.gameObject, var_15_1)
	end

	local var_15_4 = false

	if arg_15_0._mo then
		var_15_4 = arg_15_0._mo:alreadyHas() and not StoreModel.instance:isSkinGoodsCanRepeatBuy(arg_15_0._mo)
	end

	gohelper.setActive(arg_15_0._goCharge, var_15_0 and not var_15_4)
	ZProj.UGUIHelper.RebuildLayout(arg_15_0._goCharge.transform)
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0._animator
end

function var_0_0.refreshSkinTips(arg_17_0)
	gohelper.setActive(arg_17_0._goSkinTips, false)
end

function var_0_0.clearSpine(arg_18_0)
	GameUtil.doClearMember(arg_18_0, "_skinSpine")
	GameUtil.doClearMember(arg_18_0, "_skinSpine2")
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._btn:RemoveClickListener()
	arg_19_0._simagebg:UnLoadImage()
	arg_19_0._uniqueSingleImageicon:UnLoadImage()
	arg_19_0._uniqueImagebg:UnLoadImage()
	GameUtil.doClearMember(arg_19_0, "_skinSpine")
	GameUtil.doClearMember(arg_19_0, "_skinSpine2")

	if arg_19_0:_isUniqueSkin() then
		arg_19_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_19_0._onDraggingBegin, arg_19_0)
		arg_19_0:removeEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_19_0._onDraggingEnd, arg_19_0)
		arg_19_0:removeEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_19_0._onDragging, arg_19_0)
	end
end

function var_0_0._onUpdateMO_uniqueSkin(arg_20_0)
	arg_20_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListBegin, arg_20_0._onDraggingBegin, arg_20_0)
	arg_20_0:addEventCb(StoreController.instance, StoreEvent.DragSkinListEnd, arg_20_0._onDraggingEnd, arg_20_0)
	arg_20_0:addEventCb(StoreController.instance, StoreEvent.DraggingSkinList, arg_20_0._onDragging, arg_20_0)

	local var_20_0 = arg_20_0._mo.config.bigImg
	local var_20_1 = arg_20_0._mo.config.spineParams

	gohelper.setActive(arg_20_0._xtIconbg, false)
	gohelper.setActive(arg_20_0._goUniqueSkinBubble, false)
	arg_20_0._uniqueImagebg:LoadImage(ResUrl.getCharacterSkinIcon(arg_20_0._skinId))
	arg_20_0._uniqueSingleImageicon:LoadImage(ResUrl.getHeadSkinIconUnique(arg_20_0._skinId))
end

function var_0_0._isNormalSkin(arg_21_0)
	return arg_21_0._mo.config.skinLevel == 0
end

function var_0_0._isAdvanceSkin(arg_22_0)
	return arg_22_0._mo.config.isAdvancedSkin or arg_22_0._mo.config.skinLevel == 1
end

function var_0_0._isUniqueSkin(arg_23_0)
	return arg_23_0._mo.config.skinLevel == 2
end

function var_0_0._isLinkageSkin(arg_24_0)
	return arg_24_0._mo.config.islinkageSkin or false
end

function var_0_0._isShowLinkageLogo(arg_25_0)
	return arg_25_0._mo.config.showLinkageLogo or false
end

return var_0_0
