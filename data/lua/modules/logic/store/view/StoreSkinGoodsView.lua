module("modules.logic.store.view.StoreSkinGoodsView", package.seeall)

local var_0_0 = class("StoreSkinGoodsView", BaseView)
local var_0_1 = {
	45,
	-46,
	0
}
local var_0_2 = {
	-460,
	0,
	0
}
local var_0_3 = 0.85
local var_0_4 = "singlebg/signature/color/img_dressing1.png"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_leftbg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_icon")
	arg_1_0._gooffTag = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/#simage_icon/#go_offTag")
	arg_1_0._txtoff = gohelper.findChildText(arg_1_0.viewGO, "view/bgroot/#simage_icon/#go_offTag/#txt_off")
	arg_1_0._simagedreesing = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_dreesing")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_buy")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/cost/price/#txt_materialNum")
	arg_1_0._simagematerial = gohelper.findChildImage(arg_1_0.viewGO, "view/propinfo/cost/price/#txt_materialNum/#simage_material")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/cost/price/#txt_price")
	arg_1_0._godeduction = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/cost/#go_deduction")
	arg_1_0._txtdeduction = gohelper.findChildTextMesh(arg_1_0.viewGO, "view/propinfo/cost/#go_deduction/#txt_deduction")
	arg_1_0._txtskinname = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/#txt_skinname")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/content/desc/#txt_desc")
	arg_1_0._txtusedesc = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/content/desc/usedesc")
	arg_1_0._goleftbg = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/content/remain/#go_leftbg")
	arg_1_0._txtremainday = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/content/remain/#go_leftbg/#txt_remainday")
	arg_1_0._gorightbg = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/content/remain/#go_rightbg")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "view/propinfo/content/remain/#go_rightbg/#txt_remain")
	arg_1_0._scrollproduct = gohelper.findChildScrollRect(arg_1_0.viewGO, "view/propinfo/#scroll_product")
	arg_1_0._goicon = gohelper.findChild(arg_1_0.viewGO, "view/propinfo/#scroll_product/product/go_goods/#go_icon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._godeco = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/deco")
	arg_1_0._simageGeneralSkinIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_icon")
	arg_1_0._simageUniqueSkinIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_s+icon")
	arg_1_0._imageUniqueSkinIcon = gohelper.findChildImage(arg_1_0.viewGO, "view/bgroot/#simage_s+icon")
	arg_1_0._goUniqueSkinsImage = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/#simage_s+icon")
	arg_1_0._goUniqueSkinsSpineRoot = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/#simage_s+spineroot")
	arg_1_0._goUniqueSkinsTitle = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/#simage_s+decoration")
	arg_1_0._simageUniqueSkinSpineRoot = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_s+spineroot")
	arg_1_0._imageUniqueSkinSpineRoot = gohelper.findChildImage(arg_1_0.viewGO, "view/bgroot/#simage_s+spineroot")
	arg_1_0._goUniqueSkinsSpineRoot2 = gohelper.findChild(arg_1_0.viewGO, "view/bgroot/#simage_s+spineroot2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()

	if arg_3_0.btnIcon then
		arg_3_0.btnIcon:RemoveClickListener()
	end
end

function var_0_0._btnbuyOnClick(arg_4_0)
	local var_4_0 = ItemModel.instance:getItemQuantity(arg_4_0._costType, arg_4_0._costId)
	local var_4_1 = arg_4_0._costQuantity

	if arg_4_0.deductionInfo then
		var_4_1 = math.max(0, var_4_1 - arg_4_0.deductionInfo.deductionCount)
	end

	if arg_4_0.isActivityStore then
		if var_4_0 < var_4_1 then
			GameFacade.showToast(ToastEnum.DiamondBuy, arg_4_0.costName)
		else
			arg_4_0:_buyGoods()
		end
	elseif CurrencyController.instance:checkDiamondEnough(var_4_1, arg_4_0.jumpCallBack, arg_4_0) then
		arg_4_0:_buyGoods()
	end
end

function var_0_0._buyGoods(arg_5_0)
	if arg_5_0.isActivityStore then
		Activity107Rpc.instance:sendBuy107GoodsRequest(arg_5_0._mo.activityId, arg_5_0._mo.id, 1)
	else
		StoreController.instance:buyGoods(arg_5_0._mo, 1, arg_5_0._buyCallback, arg_5_0)
	end
end

function var_0_0.jumpCallBack(arg_6_0)
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	arg_6_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_8_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_8_0._goremain = gohelper.findChild(arg_8_0.viewGO, "view/propinfo/content/remain")
	arg_8_0._gonormaltitle = gohelper.findChild(arg_8_0.viewGO, "view/bgroot/#go_normal_title")
	arg_8_0._goadvancedtitle = gohelper.findChild(arg_8_0.viewGO, "view/bgroot/#go_advanced_title")
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.isActivityStore = arg_10_0.viewParam.isActivityStore

	if arg_10_0.isActivityStore then
		arg_10_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_10_0._btncloseOnClick, arg_10_0)
		arg_10_0:_updateActivityStore()
	else
		arg_10_0:_updateSkinStore()
	end

	local var_10_0 = lua_character.configDict[arg_10_0.skinCo.characterId].name

	arg_10_0._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), var_10_0)
end

function var_0_0._updateActivityStore(arg_11_0)
	arg_11_0._mo = arg_11_0.viewParam.goodsMO

	local var_11_0 = arg_11_0._mo.product
	local var_11_1 = string.splitToNumber(var_11_0, "#")[2]

	arg_11_0.skinCo = SkinConfig.instance:getSkinCo(var_11_1)
	arg_11_0._txtskinname.text = arg_11_0.skinCo.characterSkin
	arg_11_0._txtdesc.text = arg_11_0.skinCo.skinDescription

	recthelper.setAnchorY(arg_11_0._txtdesc.transform, -100)

	local var_11_2 = string.splitToNumber(arg_11_0._mo.cost, "#")

	arg_11_0._costType = var_11_2[1]
	arg_11_0._costId = var_11_2[2]
	arg_11_0._costQuantity = var_11_2[3]

	local var_11_3, var_11_4 = ItemModel.instance:getItemConfigAndIcon(arg_11_0._costType, arg_11_0._costId)

	arg_11_0.costName = var_11_3.name

	if ItemModel.instance:getItemQuantity(arg_11_0._costType, arg_11_0._costId) >= arg_11_0._costQuantity then
		SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtmaterialNum, "#bf2e11")
	end

	arg_11_0._txtmaterialNum.text = arg_11_0._costQuantity

	local var_11_5 = var_11_3.icon
	local var_11_6 = string.format("%s_1", var_11_5)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_11_0._simagematerial, var_11_6)
	arg_11_0.viewContainer:setCurrencyType({
		arg_11_0._costId
	})
	arg_11_0._simageicon:LoadImage(ResUrl.getStoreSkin(var_11_1))

	if not arg_11_0.btnIcon then
		arg_11_0.btnIcon = gohelper.getClick(arg_11_0._simageicon.gameObject)

		arg_11_0.btnIcon:AddClickListener(arg_11_0.onClickIcon, arg_11_0)
	end

	gohelper.setActive(arg_11_0._txtprice.gameObject, false)
	arg_11_0:_enableRemain(false)
	gohelper.setActive(arg_11_0._gooffTag, false)
	gohelper.setActive(arg_11_0._gonormaltitle, true)
	gohelper.setActive(arg_11_0._goadvancedtitle, false)
end

function var_0_0._updateSkinStore(arg_12_0)
	arg_12_0._mo = arg_12_0.viewParam.goodsMO

	local var_12_0 = arg_12_0._mo.config.product
	local var_12_1 = string.splitToNumber(var_12_0, "#")[2]

	arg_12_0.skinCo = SkinConfig.instance:getSkinCo(var_12_1)

	local var_12_2 = arg_12_0._mo.config
	local var_12_3 = string.splitToNumber(var_12_2.cost, "#")

	arg_12_0._costType = var_12_3[1]
	arg_12_0._costId = var_12_3[2]
	arg_12_0._costQuantity = var_12_3[3]

	if not string.nilorempty(arg_12_0._mo.config.deductionItem) then
		local var_12_4 = GameUtil.splitString2(arg_12_0._mo.config.deductionItem, true)

		if ItemModel.instance:getItemCount(var_12_4[1][2]) > 0 then
			arg_12_0.deductionInfo = {
				deductionCount = var_12_4[2][1],
				currencyType = {
					isCurrencySprite = true,
					type = var_12_4[1][1],
					id = var_12_4[1][2]
				}
			}
		end
	else
		arg_12_0.deductionInfo = nil
	end

	arg_12_0:_refreshSkinDesc(var_12_2, arg_12_0.skinCo)
	arg_12_0:_refreshSkinCost(var_12_2)
	arg_12_0:_refreshSkinIcon(var_12_2)
end

function var_0_0._refreshSkinDesc(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._txtskinname.text = arg_13_2.characterSkin
	arg_13_0._txtdesc.text = arg_13_2.skinDescription

	local var_13_0 = arg_13_0._mo:getOfflineTime()

	if var_13_0 > 0 then
		local var_13_1 = math.floor(var_13_0 - ServerTime.now())

		arg_13_0:_enableRemain(true)

		arg_13_0._txtremainday.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_13_1))
	else
		gohelper.setActive(arg_13_0._goremain, false)
		arg_13_0:_enableRemain(false)
	end

	gohelper.setActive(arg_13_0._gooffTag, arg_13_1.originalCost > 0)

	local var_13_2 = arg_13_0._costQuantity / arg_13_1.originalCost
	local var_13_3 = math.ceil(var_13_2 * 100)

	arg_13_0._txtoff.text = string.format("-%d%%", 100 - var_13_3)
end

function var_0_0._refreshSkinCost(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = ItemModel.instance:getItemConfigAndIcon(arg_14_0._costType, arg_14_0._costId)
	local var_14_2 = arg_14_0._costQuantity

	if arg_14_0.deductionInfo then
		var_14_2 = math.max(0, var_14_2 - arg_14_0.deductionInfo.deductionCount)

		gohelper.setActive(arg_14_0._godeduction, true)

		local var_14_3 = ItemModel.instance:getItemConfigAndIcon(arg_14_0._costType, arg_14_0._costId)

		arg_14_0._txtdeduction.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("bp_deduction_item_count"), tostring(arg_14_0.deductionInfo.deductionCount), var_14_3.name)
	else
		gohelper.setActive(arg_14_0._godeduction, false)
	end

	if var_14_2 <= ItemModel.instance:getItemQuantity(arg_14_0._costType, arg_14_0._costId) then
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._txtmaterialNum, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._txtmaterialNum, "#bf2e11")
	end

	arg_14_0._txtmaterialNum.text = var_14_2

	local var_14_4 = var_14_0.icon
	local var_14_5 = string.format("%s_1", var_14_4)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_14_0._simagematerial, var_14_5)

	local var_14_6 = {}

	if arg_14_0._costId ~= CurrencyEnum.CurrencyType.Diamond then
		table.insert(var_14_6, CurrencyEnum.CurrencyType.Diamond)
	end

	table.insert(var_14_6, arg_14_0._costId)

	if arg_14_0.deductionInfo then
		table.insert(var_14_6, arg_14_0.deductionInfo.currencyType)
	end

	arg_14_0.viewContainer:setCurrencyType(var_14_6)
	gohelper.setActive(arg_14_0._txtprice.gameObject, arg_14_1.originalCost > 0 or arg_14_0.deductionInfo)

	arg_14_0._txtprice.text = arg_14_1.originalCost > 0 and arg_14_1.originalCost or arg_14_0._costQuantity
end

function var_0_0._refreshSkinIcon(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._mo.config.isAdvancedSkin or arg_15_0._mo.config.skinLevel == 1
	local var_15_1 = arg_15_0._mo.config.skinLevel == 2

	gohelper.setActive(arg_15_0._godeco, not var_15_1)
	gohelper.setActive(arg_15_0._gonormaltitle, not var_15_0 and not var_15_1)
	gohelper.setActive(arg_15_0._goadvancedtitle, var_15_0)
	gohelper.setActive(arg_15_0._simageGeneralSkinIcon.gameObject, not var_15_1)
	gohelper.setActive(arg_15_0._goUniqueSkinsImage, var_15_1)
	gohelper.setActive(arg_15_0._goUniqueSkinsSpineRoot, var_15_1)
	gohelper.setActive(arg_15_0._goUniqueSkinsSpineRoot2, var_15_1)
	gohelper.setActive(arg_15_0._goUniqueSkinsTitle, var_15_1)

	local var_15_2 = var_0_4

	if var_15_1 then
		arg_15_0._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))

		local var_15_3 = arg_15_0._mo.config.bigImg
		local var_15_4 = arg_15_0._mo.config.spineParams

		if not string.nilorempty(var_15_4) then
			local var_15_5 = string.split(var_15_4, "#")
			local var_15_6 = #var_15_5
			local var_15_7 = var_15_5[1]
			local var_15_8 = var_15_5[2]
			local var_15_9 = string.splitToNumber(var_15_5[3], ",")
			local var_15_10 = var_15_5[6]

			var_15_2 = var_15_6 > 6 and var_15_5[7] or var_15_2

			if arg_15_0._skinSpine then
				arg_15_0._skinSpine:setResPath(var_15_7, arg_15_0._onSpine1Loaded, arg_15_0, true)
			else
				arg_15_0._skinSpineGO = gohelper.create2d(arg_15_0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

				local var_15_11 = arg_15_0._skinSpineGO.transform

				transformhelper.setLocalPos(var_15_11, var_15_9[1], var_15_9[2], 0)

				arg_15_0._skinSpine = GuiSpine.Create(arg_15_0._skinSpineGO, false)

				arg_15_0._skinSpine:setResPath(var_15_7, arg_15_0._onSpine1Loaded, arg_15_0, true)

				if not string.nilorempty(var_15_8) then
					arg_15_0._skinSpineGO2 = gohelper.create2d(arg_15_0._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

					local var_15_12 = arg_15_0._skinSpineGO2.transform

					transformhelper.setLocalPos(var_15_12, var_15_9[1], var_15_9[2], 0)

					arg_15_0._skinSpine2 = GuiSpine.Create(arg_15_0._skinSpineGO2, false)

					arg_15_0._skinSpine2:setResPath(var_15_8, arg_15_0._onSpine2Loaded, arg_15_0, true)
				end
			end

			if not string.nilorempty(var_15_10) then
				arg_15_0._simageUniqueSkinIcon:LoadImage(var_15_10)
				arg_15_0._simageUniqueSkinSpineRoot:LoadImage(var_15_10)
			else
				gohelper.setActive(arg_15_0._uniqueImagebg.gameObject, false)
			end

			gohelper.setActive(arg_15_0._skinSpineGO, true)
		elseif string.find(var_15_3, "prefab") then
			gohelper.setActive(arg_15_0._goUniqueSkinsTitle, false)

			local var_15_13 = string.split(var_15_3, "#")
			local var_15_14 = #var_15_13
			local var_15_15 = var_15_13[1]
			local var_15_16 = var_15_13[3]

			var_15_2 = var_15_14 > 3 and var_15_13[4] or var_15_2

			if arg_15_0._skinSpine then
				arg_15_0._skinSpine:setResPath(var_15_15, arg_15_0._onSpineLoaded, arg_15_0, true)
			else
				arg_15_0._skinSpineGO = gohelper.create2d(arg_15_0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")
				arg_15_0._skinSpine = GuiSpine.Create(arg_15_0._skinSpineGO, false)

				transformhelper.setLocalPos(arg_15_0._skinSpineGO.transform, var_0_1[1], var_0_1[2], var_0_1[3])
				arg_15_0._skinSpine:setResPath(var_15_15, arg_15_0._onSpineLoaded, arg_15_0, true)
				transformhelper.setLocalPos(arg_15_0._goUniqueSkinsSpineRoot.transform, var_0_2[1], var_0_2[2], 0)
			end

			arg_15_0._simageUniqueSkinIcon:LoadImage(var_15_16, arg_15_0._loadedSpineBgDone, arg_15_0)
			transformhelper.setLocalPos(arg_15_0._simageUniqueSkinIcon.transform, var_0_2[1], var_0_2[2], var_0_2[3])
			arg_15_0._imageUniqueSkinIcon:SetNativeSize()
			arg_15_0._imageUniqueSkinSpineRoot:SetNativeSize()
			gohelper.setActive(arg_15_0._skinSpineGO, true)
		elseif not string.nilorempty(var_15_3) then
			arg_15_0._simageUniqueSkinIcon:LoadImage(arg_15_0._mo.config.bigImg)
		else
			arg_15_0._simageUniqueSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	elseif string.nilorempty(arg_15_1.bigImg) == false then
		arg_15_0._simageGeneralSkinIcon:LoadImage(arg_15_1.bigImg)
	else
		arg_15_0._simageGeneralSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
	end

	arg_15_0._simagedreesing:LoadImage(var_15_2, arg_15_0._loadedSignImage, arg_15_0)
end

function var_0_0._loadedSignImage(arg_16_0)
	gohelper.onceAddComponent(arg_16_0._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0._loadedSpineBgDone(arg_17_0)
	gohelper.onceAddComponent(arg_17_0._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0._onSpine1Loaded(arg_18_0)
	local var_18_0 = arg_18_0._skinSpine:getSpineTr()

	transformhelper.setLocalScale(var_18_0, var_0_3, var_0_3, 1)
end

function var_0_0._onSpine2Loaded(arg_19_0)
	local var_19_0 = arg_19_0._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(var_19_0, var_0_3, var_0_3, 1)
end

function var_0_0._onSpineLoaded(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = 0
	local var_20_2 = 0.88
	local var_20_3 = 0.84
	local var_20_4 = arg_20_0._skinSpine:getSpineTr()
	local var_20_5 = arg_20_0._simageUniqueSkinIcon.transform

	recthelper.setAnchor(var_20_4, recthelper.getAnchor(var_20_5))
	recthelper.setWidth(var_20_4, recthelper.getWidth(var_20_5))
	recthelper.setHeight(var_20_4, recthelper.getHeight(var_20_5))
	recthelper.setAnchor(var_20_4, var_20_0, var_20_1)
	transformhelper.setLocalScale(var_20_4, var_20_2, var_20_3, 1)
	arg_20_0:setSpineRaycastTarget(arg_20_0._raycastTarget)
end

function var_0_0.setSpineRaycastTarget(arg_21_0, arg_21_1)
	arg_21_0._raycastTarget = arg_21_1 == true and true or false

	if arg_21_0._skinSpine then
		local var_21_0 = arg_21_0._skinSpine:getSkeletonGraphic()

		if var_21_0 then
			var_21_0.raycastTarget = arg_21_0._raycastTarget
		end
	end
end

function var_0_0._buyCallback(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 == 0 then
		arg_22_0:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function var_0_0._enableRemain(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._goremain, arg_23_1)

	local var_23_0 = arg_23_1 and -140 or -88

	recthelper.setAnchorY(arg_23_0._txtdesc.transform, var_23_0)
end

function var_0_0.onClickIcon(arg_24_0)
	if not arg_24_0.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, arg_24_0.skinCo.id, false, nil, false)
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simageleftbg:UnLoadImage()
	arg_26_0._simagerightbg:UnLoadImage()
	arg_26_0._simagedreesing:UnLoadImage()

	if arg_26_0._skinSpine then
		arg_26_0._skinSpine:doClear()

		arg_26_0._skinSpine = nil
	end

	if arg_26_0._skinSpine2 then
		arg_26_0._skinSpine2:doClear()

		arg_26_0._skinSpine2 = nil
	end
end

return var_0_0
