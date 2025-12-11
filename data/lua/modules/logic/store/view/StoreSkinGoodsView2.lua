module("modules.logic.store.view.StoreSkinGoodsView2", package.seeall)

local var_0_0 = class("StoreSkinGoodsView2", BaseView)
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
	arg_1_0._simagedreesing = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bgroot/#simage_dreesing")
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
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/#btn_buy")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "view/common/cost")
	arg_1_0._btncost1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/cost/#btn_cost1")
	arg_1_0._gounselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect")
	arg_1_0._goiconunselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/icon")
	arg_1_0._imageiconunselect1 = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	arg_1_0._txtcurpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	arg_1_0._txtoriginalpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	arg_1_0._goselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select")
	arg_1_0._goiconselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select/icon")
	arg_1_0._imageiconselect1 = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	arg_1_0._txtcurpriceselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	arg_1_0._txtoriginalpriceselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	arg_1_0._btncost2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/cost/#btn_cost2")
	arg_1_0._gounselect2 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost2/unselect")
	arg_1_0._imageiconunselect2 = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	arg_1_0._txtcurpriceunselect2 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	arg_1_0._txtoriginalpriceunselect2 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	arg_1_0._goselect2 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost2/select")
	arg_1_0._imageiconselect2 = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	arg_1_0._txtcurpriceselect2 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	arg_1_0._txtoriginalpriceselect2 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	arg_1_0._gocostsingle = gohelper.findChild(arg_1_0.viewGO, "view/common/cost_single")
	arg_1_0._imageiconsingle = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost_single/simage_material")
	arg_1_0._txtcurpricesingle = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost_single/#txt_materialNum")
	arg_1_0._txtoriginalpricesingle = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost_single/#txt_price")
	arg_1_0.goDiscount3 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost2/#go_discount3")
	arg_1_0.txtDiscount3 = gohelper.findChildTextMesh(arg_1_0.viewGO, "view/common/cost/#btn_cost2/#go_discount3/#txt_cost_price")
	arg_1_0.goStoreSkinTips = gohelper.findChild(arg_1_0.viewGO, "view/#go_storeskin")
	arg_1_0.txtStoreSkinTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "view/#go_storeskin/tips/#txt_tips")
	arg_1_0.simageStoreSkinTips = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#go_storeskin/#simage_package")
	arg_1_0.btnSkinTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_storeskin/#simage_package")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncost1:AddClickListener(arg_2_0._btncost1OnClick, arg_2_0)
	arg_2_0._btncost2:AddClickListener(arg_2_0._btncost2OnClick, arg_2_0)
	arg_2_0.btnSkinTips:AddClickListener(arg_2_0._btnSkinTipsOnClick, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._payFinished, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncost1:RemoveClickListener()
	arg_3_0._btncost2:RemoveClickListener()
	arg_3_0.btnSkinTips:RemoveClickListener()
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._payFinished, arg_3_0)
end

function var_0_0._payFinished(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.setCurCostIndex(arg_5_0, arg_5_1)
	arg_5_0._curCostIndex = arg_5_1
end

function var_0_0.getCurCostIndex(arg_6_0)
	return arg_6_0._curCostIndex or 1
end

function var_0_0._btnSkinTipsOnClick(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	local var_7_0 = arg_7_0._mo.config
	local var_7_1 = string.splitToNumber(var_7_0.product, "#")[2]
	local var_7_2, var_7_3 = StoreModel.instance:isSkinHasStoreId(var_7_1)

	if not var_7_2 then
		return
	end

	local var_7_4 = StoreModel.instance:getGoodsMO(var_7_3)

	if not var_7_4 then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(var_7_4)
end

function var_0_0._btncost1OnClick(arg_8_0)
	if arg_8_0:getCurCostIndex() == 1 then
		return
	end

	arg_8_0:setCurCostIndex(1)
	arg_8_0:refreshCost()
end

function var_0_0._btncost2OnClick(arg_9_0)
	if arg_9_0:getCurCostIndex() == 2 then
		return
	end

	arg_9_0:setCurCostIndex(2)
	arg_9_0:refreshCost()
end

function var_0_0._btnbuyOnClick(arg_10_0)
	if not arg_10_0._mo then
		return
	end

	local var_10_0 = arg_10_0:getCurCostIndex()
	local var_10_1 = arg_10_0._mo.config.product
	local var_10_2 = string.splitToNumber(var_10_1, "#")[2]
	local var_10_3 = SkinConfig.instance:getSkinCo(var_10_2)

	if StoreModel.instance:isSkinCanShowMessageBox(var_10_2) then
		local var_10_4 = var_10_3.skinStoreId
		local var_10_5 = StoreModel.instance:getGoodsMO(var_10_4)

		local function var_10_6()
			StoreController.instance:openStoreView(StoreEnum.StoreId.VersionPackage, var_10_4)
			arg_10_0:closeThis()
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.SkinGoodsJumpTips, MsgBoxEnum.BoxType.Yes_No, var_10_6, nil, nil, nil, nil, nil, var_10_5.config.name)
	elseif var_10_0 == 1 then
		local var_10_7 = StoreConfig.instance:getSkinChargeGoodsId(var_10_2)

		if var_10_7 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
			PayController.instance:startPay(var_10_7)
		else
			GameFacade.showToast(ToastEnum.CanNotBuy)
		end
	else
		local var_10_8 = string.splitToNumber(arg_10_0._mo.config.cost, "#")[3]

		if CurrencyController.instance:checkDiamondEnough(var_10_8, arg_10_0.jumpCallBack, arg_10_0) then
			arg_10_0:_buyGoods()
		end
	end
end

function var_0_0._buyGoods(arg_12_0)
	StoreController.instance:buyGoods(arg_12_0._mo, 1, arg_12_0._buyCallback, arg_12_0)
end

function var_0_0.jumpCallBack(arg_13_0)
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	arg_13_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_14_0)
	arg_14_0:closeThis()
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_15_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_15_0._goremain = gohelper.findChild(arg_15_0.viewGO, "view/propinfo/content/remain")
	arg_15_0._gonormaltitle = gohelper.findChild(arg_15_0.viewGO, "view/bgroot/#go_normal_title")
	arg_15_0._goadvancedtitle = gohelper.findChild(arg_15_0.viewGO, "view/bgroot/#go_advanced_title")
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:setCurCostIndex(arg_17_0.viewParam and arg_17_0.viewParam.index or 1)
	arg_17_0:_updateSkinStore()

	local var_17_0 = lua_character.configDict[arg_17_0.skinCo.characterId].name

	arg_17_0._txtusedesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), var_17_0)

	if arg_17_0._mo then
		StoreController.instance:statOpenChargeGoods(arg_17_0._mo.belongStoreId, arg_17_0._mo.config)
	end
end

function var_0_0._updateSkinStore(arg_18_0)
	arg_18_0._mo = arg_18_0.viewParam.goodsMO

	local var_18_0 = arg_18_0._mo.config.product
	local var_18_1 = string.splitToNumber(var_18_0, "#")[2]

	arg_18_0.skinCo = SkinConfig.instance:getSkinCo(var_18_1)

	local var_18_2 = arg_18_0._mo.config
	local var_18_3 = string.splitToNumber(var_18_2.cost, "#")

	arg_18_0._costType = var_18_3[1]
	arg_18_0._costId = var_18_3[2]
	arg_18_0._costQuantity = var_18_3[3]

	if not string.nilorempty(arg_18_0._mo.config.deductionItem) then
		local var_18_4 = GameUtil.splitString2(arg_18_0._mo.config.deductionItem, true)

		if ItemModel.instance:getItemCount(var_18_4[1][2]) > 0 then
			arg_18_0.deductionInfo = {
				deductionCount = var_18_4[2][1],
				currencyType = {
					isCurrencySprite = true,
					type = var_18_4[1][1],
					id = var_18_4[1][2]
				}
			}
		end
	else
		arg_18_0.deductionInfo = nil
	end

	arg_18_0:_refreshSkinDesc(var_18_2, arg_18_0.skinCo)
	arg_18_0:refreshCost(var_18_2)
	arg_18_0:_refreshSkinIcon(var_18_2)
	arg_18_0:refreshStoreSkinTips()
end

function var_0_0._refreshSkinDesc(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._txtskinname.text = arg_19_2.characterSkin
	arg_19_0._txtdesc.text = arg_19_2.skinDescription

	local var_19_0 = arg_19_0._mo:getOfflineTime()

	if var_19_0 > 0 then
		local var_19_1 = math.floor(var_19_0 - ServerTime.now())

		gohelper.setActive(arg_19_0._goremain, true)

		arg_19_0._txtremainday.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_19_1))
	else
		gohelper.setActive(arg_19_0._goremain, false)
	end
end

function var_0_0._refreshSkinIcon(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._mo.config.isAdvancedSkin or arg_20_0._mo.config.skinLevel == 1
	local var_20_1 = arg_20_0._mo.config.skinLevel == 2

	gohelper.setActive(arg_20_0._godeco, not var_20_1)
	gohelper.setActive(arg_20_0._gonormaltitle, not var_20_0 and not var_20_1)
	gohelper.setActive(arg_20_0._goadvancedtitle, var_20_0)
	gohelper.setActive(arg_20_0._simageGeneralSkinIcon.gameObject, not var_20_1)
	gohelper.setActive(arg_20_0._goUniqueSkinsImage, var_20_1)
	gohelper.setActive(arg_20_0._goUniqueSkinsSpineRoot, var_20_1)
	gohelper.setActive(arg_20_0._goUniqueSkinsSpineRoot2, var_20_1)
	gohelper.setActive(arg_20_0._goUniqueSkinsTitle, var_20_1)

	local var_20_2 = var_0_4

	if var_20_1 then
		arg_20_0._simagedreesing:LoadImage(ResUrl.getCharacterSkinIcon("bg_zhuangshi"))

		local var_20_3 = arg_20_0._mo.config.bigImg
		local var_20_4 = arg_20_0._mo.config.spineParams

		if not string.nilorempty(var_20_4) then
			local var_20_5 = string.split(var_20_4, "#")
			local var_20_6 = #var_20_5
			local var_20_7 = var_20_5[1]
			local var_20_8 = var_20_5[2]
			local var_20_9 = string.splitToNumber(var_20_5[3], ",")
			local var_20_10 = var_20_5[6]

			var_20_2 = var_20_6 > 6 and var_20_5[7] or var_20_2

			if arg_20_0._skinSpine then
				arg_20_0._skinSpine:setResPath(var_20_7, arg_20_0._onSpine1Loaded, arg_20_0, true)
			else
				arg_20_0._skinSpineGO = gohelper.create2d(arg_20_0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")

				local var_20_11 = arg_20_0._skinSpineGO.transform

				transformhelper.setLocalPos(var_20_11, var_20_9[1], var_20_9[2], 0)

				arg_20_0._skinSpine = GuiSpine.Create(arg_20_0._skinSpineGO, false)

				arg_20_0._skinSpine:setResPath(var_20_7, arg_20_0._onSpine1Loaded, arg_20_0, true)

				if not string.nilorempty(var_20_8) then
					arg_20_0._skinSpineGO2 = gohelper.create2d(arg_20_0._goUniqueSkinsSpineRoot2, "uniqueSkinSpine2")

					local var_20_12 = arg_20_0._skinSpineGO2.transform

					transformhelper.setLocalPos(var_20_12, var_20_9[1], var_20_9[2], 0)

					arg_20_0._skinSpine2 = GuiSpine.Create(arg_20_0._skinSpineGO2, false)

					arg_20_0._skinSpine2:setResPath(var_20_8, arg_20_0._onSpine2Loaded, arg_20_0, true)
				end
			end

			if not string.nilorempty(var_20_10) then
				arg_20_0._simageUniqueSkinIcon:LoadImage(var_20_10)
				arg_20_0._simageUniqueSkinSpineRoot:LoadImage(var_20_10)
			end

			gohelper.setActive(arg_20_0._skinSpineGO, true)
		elseif string.find(var_20_3, "prefab") then
			gohelper.setActive(arg_20_0._goUniqueSkinsTitle, false)

			local var_20_13 = string.split(var_20_3, "#")
			local var_20_14 = #var_20_13
			local var_20_15 = var_20_13[1]
			local var_20_16 = var_20_13[3]

			var_20_2 = var_20_14 > 3 and var_20_13[4] or var_20_2

			if arg_20_0._skinSpine then
				arg_20_0._skinSpine:setResPath(var_20_15, arg_20_0._onSpineLoaded, arg_20_0, true)
			else
				arg_20_0._skinSpineGO = gohelper.create2d(arg_20_0._goUniqueSkinsSpineRoot, "uniqueSkinSpine")
				arg_20_0._skinSpine = GuiSpine.Create(arg_20_0._skinSpineGO, false)

				transformhelper.setLocalPos(arg_20_0._skinSpineGO.transform, var_0_1[1], var_0_1[2], var_0_1[3])
				arg_20_0._skinSpine:setResPath(var_20_15, arg_20_0._onSpineLoaded, arg_20_0, true)
				transformhelper.setLocalPos(arg_20_0._goUniqueSkinsSpineRoot.transform, var_0_2[1], var_0_2[2], 0)
			end

			arg_20_0._simageUniqueSkinIcon:LoadImage(var_20_16, arg_20_0._loadedSpineBgDone, arg_20_0)
			transformhelper.setLocalPos(arg_20_0._simageUniqueSkinIcon.transform, var_0_2[1], var_0_2[2], var_0_2[3])
			arg_20_0._imageUniqueSkinIcon:SetNativeSize()
			arg_20_0._imageUniqueSkinSpineRoot:SetNativeSize()
			gohelper.setActive(arg_20_0._skinSpineGO, true)
		elseif not string.nilorempty(var_20_3) then
			arg_20_0._simageUniqueSkinIcon:LoadImage(arg_20_0._mo.config.bigImg)
		else
			arg_20_0._simageUniqueSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
		end
	elseif string.nilorempty(arg_20_1.bigImg) == false then
		arg_20_0._simageGeneralSkinIcon:LoadImage(arg_20_1.bigImg)
	else
		arg_20_0._simageGeneralSkinIcon:LoadImage(ResUrl.getHeadSkinIconMiddle(303202))
	end

	arg_20_0._simagedreesing:LoadImage(var_20_2, arg_20_0._loadedSignImage, arg_20_0)
end

function var_0_0._loadedSignImage(arg_21_0)
	gohelper.onceAddComponent(arg_21_0._simagedreesing.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0._loadedSpineBgDone(arg_22_0)
	gohelper.onceAddComponent(arg_22_0._simageUniqueSkinIcon.gameObject, gohelper.Type_Image):SetNativeSize()
end

function var_0_0._onSpine1Loaded(arg_23_0)
	local var_23_0 = arg_23_0._skinSpine:getSpineTr()

	transformhelper.setLocalScale(var_23_0, var_0_3, var_0_3, 1)
end

function var_0_0._onSpine2Loaded(arg_24_0)
	local var_24_0 = arg_24_0._skinSpine2:getSpineTr()

	transformhelper.setLocalScale(var_24_0, var_0_3, var_0_3, 1)
end

function var_0_0._onSpineLoaded(arg_25_0)
	local var_25_0 = 0
	local var_25_1 = 0
	local var_25_2 = 0.88
	local var_25_3 = 0.84
	local var_25_4 = arg_25_0._skinSpine:getSpineTr()
	local var_25_5 = arg_25_0._simageUniqueSkinIcon.transform

	recthelper.setAnchor(var_25_4, recthelper.getAnchor(var_25_5))
	recthelper.setWidth(var_25_4, recthelper.getWidth(var_25_5))
	recthelper.setHeight(var_25_4, recthelper.getHeight(var_25_5))
	recthelper.setAnchor(var_25_4, var_25_0, var_25_1)
	transformhelper.setLocalScale(var_25_4, var_25_2, var_25_3, 1)
	arg_25_0:setSpineRaycastTarget(arg_25_0._raycastTarget)
end

function var_0_0.setSpineRaycastTarget(arg_26_0, arg_26_1)
	arg_26_0._raycastTarget = arg_26_1 == true and true or false

	if arg_26_0._skinSpine then
		local var_26_0 = arg_26_0._skinSpine:getSkeletonGraphic()

		if var_26_0 then
			var_26_0.raycastTarget = arg_26_0._raycastTarget
		end
	end
end

function var_0_0.refreshStoreSkinTips(arg_27_0)
	local var_27_0 = arg_27_0._mo.config
	local var_27_1 = string.splitToNumber(var_27_0.product, "#")[2]
	local var_27_2, var_27_3 = StoreModel.instance:isSkinHasStoreId(var_27_1)

	gohelper.setActive(arg_27_0.goStoreSkinTips, var_27_2)

	if not var_27_2 then
		return
	end

	local var_27_4 = StoreModel.instance:getGoodsMO(var_27_3)

	if not var_27_4 then
		return
	end

	local var_27_5 = luaLang("storeskingoodsview2_storeskin_txt_tips")

	arg_27_0.txtStoreSkinTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_27_5, var_27_4.config.name)

	local var_27_6 = ResUrl.getStorePackageIcon("detail_" .. var_27_4.config.bigImg)

	arg_27_0.simageStoreSkinTips:LoadImage(var_27_6, function()
		ZProj.UGUIHelper.SetImageSize(arg_27_0.simageStoreSkinTips.gameObject)
	end)
end

function var_0_0.refreshCost(arg_29_0)
	local var_29_0 = {}
	local var_29_1 = arg_29_0._mo.config

	if string.nilorempty(var_29_1.cost) then
		gohelper.setActive(arg_29_0._gocost, false)

		return
	end

	gohelper.setActive(arg_29_0._gocost, true)

	local var_29_2 = arg_29_0:getCurCostIndex()
	local var_29_3 = string.splitToNumber(var_29_1.product, "#")[2]
	local var_29_4 = SkinConfig.instance:getSkinCo(var_29_3)
	local var_29_5
	local var_29_6

	if var_29_4 and StoreModel.instance:isStoreSkinChargePackageValid(var_29_3) then
		var_29_5, var_29_6 = StoreConfig.instance:getSkinChargePrice(var_29_3)
	end

	local var_29_7 = string.splitToNumber(var_29_1.cost, "#")

	table.insert(var_29_0, var_29_7[2])

	local var_29_8 = 0

	if not string.nilorempty(var_29_1.deductionItem) then
		local var_29_9 = GameUtil.splitString2(var_29_1.deductionItem, true)

		var_29_8 = ItemModel.instance:getItemCount(var_29_9[1][2])
		arg_29_0.txtDiscount3.text = -var_29_9[2][1]

		if var_29_8 > 0 then
			table.insert(var_29_0, {
				isCurrencySprite = true,
				type = var_29_9[1][1],
				id = var_29_9[1][2]
			})
		end
	end

	gohelper.setActive(arg_29_0.goDiscount3, var_29_8 > 0)
	arg_29_0.viewContainer:setCurrencyType(var_29_0)

	local var_29_10 = var_29_7[3] / var_29_1.originalCost
	local var_29_11 = math.ceil(var_29_10 * 100)

	if var_29_11 > 0 and var_29_11 < 100 then
		gohelper.setActive(arg_29_0._godiscount, true)

		arg_29_0._txtdiscount.text = string.format("-%d%%", 100 - var_29_11)
	else
		gohelper.setActive(arg_29_0._godiscount, false)
	end

	if not var_29_5 then
		gohelper.setActive(arg_29_0._gocost, false)
		gohelper.setActive(arg_29_0._gocostsingle, true)

		local var_29_12, var_29_13 = ItemModel.instance:getItemConfigAndIcon(var_29_7[1], var_29_7[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_29_0._imageiconsingle, var_29_12.icon .. "_1", true)

		if ItemModel.instance:getItemQuantity(var_29_7[1], var_29_7[2]) >= var_29_7[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpricesingle, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpricesingle, "#bf2e11")
		end

		arg_29_0._txtcurpricesingle.text = var_29_7[3]

		if var_29_1.originalCost > 0 then
			gohelper.setActive(arg_29_0._txtoriginalpricesingle.gameObject, true)

			arg_29_0._txtoriginalpricesingle.text = var_29_1.originalCost
		else
			gohelper.setActive(arg_29_0._txtoriginalpricesingle.gameObject, false)
		end

		return
	end

	gohelper.setActive(arg_29_0._gocost, true)
	gohelper.setActive(arg_29_0._gocostsingle, false)

	local var_29_14 = string.format("%s%s", StoreModel.instance:getCostStr(var_29_5))

	arg_29_0._txtcurpriceunselect1.text = var_29_14
	arg_29_0._txtcurpriceselect1.text = var_29_14

	SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceunselect1, "#393939")
	SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceselect1, "#ffffff")

	if var_29_6 then
		gohelper.setActive(arg_29_0._txtoriginalpriceselect1.gameObject, true)
		gohelper.setActive(arg_29_0._txtoriginalpriceunselect1.gameObject, true)

		arg_29_0._txtoriginalpriceselect1.text = var_29_6
		arg_29_0._txtoriginalpriceunselect1.text = var_29_6
	else
		gohelper.setActive(arg_29_0._txtoriginalpriceselect1.gameObject, false)
		gohelper.setActive(arg_29_0._txtoriginalpriceunselect1.gameObject, false)
	end

	gohelper.setActive(arg_29_0._goselect1, var_29_2 == 1)
	gohelper.setActive(arg_29_0._gounselect1, var_29_2 ~= 1)

	local var_29_15, var_29_16 = ItemModel.instance:getItemConfigAndIcon(var_29_7[1], var_29_7[2])

	arg_29_0._txtcurpriceunselect2.text = var_29_7[3]
	arg_29_0._txtcurpriceselect2.text = var_29_7[3]

	if ItemModel.instance:getItemQuantity(var_29_7[1], var_29_7[2]) >= var_29_7[3] then
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceunselect2, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceselect2, "#ffffff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceunselect2, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtcurpriceselect2, "#bf2e11")
	end

	if var_29_1.originalCost > 0 then
		gohelper.setActive(arg_29_0._txtoriginalpriceselect2.gameObject, true)
		gohelper.setActive(arg_29_0._txtoriginalpriceunselect2.gameObject, true)

		arg_29_0._txtoriginalpriceselect2.text = var_29_1.originalCost
		arg_29_0._txtoriginalpriceunselect2.text = var_29_1.originalCost
	else
		gohelper.setActive(arg_29_0._txtoriginalpriceselect2.gameObject, false)
		gohelper.setActive(arg_29_0._txtoriginalpriceunselect2.gameObject, false)
	end

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_29_0._imageiconselect2, var_29_15.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_29_0._imageiconunselect2, var_29_15.icon .. "_1", true)
	gohelper.setActive(arg_29_0._goselect2, var_29_2 == 2)
	gohelper.setActive(arg_29_0._gounselect2, var_29_2 ~= 2)
end

function var_0_0._buyCallback(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_2 == 0 then
		arg_30_0:closeThis()
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end
end

function var_0_0.onClickIcon(arg_31_0)
	if not arg_31_0.skinCo then
		return
	end

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, arg_31_0.skinCo.id, false, nil, false)
end

function var_0_0.onClose(arg_32_0)
	return
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._simageleftbg:UnLoadImage()
	arg_33_0._simagerightbg:UnLoadImage()
	arg_33_0._simagedreesing:UnLoadImage()

	if arg_33_0._skinSpine then
		arg_33_0._skinSpine:doClear()

		arg_33_0._skinSpine = nil
	end

	if arg_33_0._skinSpine2 then
		arg_33_0._skinSpine2:doClear()

		arg_33_0._skinSpine2 = nil
	end

	arg_33_0.simageStoreSkinTips:UnLoadImage()
end

return var_0_0
