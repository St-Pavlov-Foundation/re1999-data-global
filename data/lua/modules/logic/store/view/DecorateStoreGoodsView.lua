module("modules.logic.store.view.DecorateStoreGoodsView", package.seeall)

local var_0_0 = class("DecorateStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_blur")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_leftbg")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "view/common/title/#txt_goodsNameCn")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/#btn_buy")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	arg_1_0._godiscount2 = gohelper.findChild(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount2")
	arg_1_0._txtdiscount2 = gohelper.findChildText(arg_1_0.viewGO, "view/common/#btn_buy/#go_discount2/#txt_discount")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "view/common/cost")
	arg_1_0._btncost1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/cost/#btn_cost1")
	arg_1_0._gounselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect")
	arg_1_0._imageiconunselect1 = gohelper.findChildImage(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	arg_1_0._txtcurpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	arg_1_0._txtoriginalpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	arg_1_0._goselect1 = gohelper.findChild(arg_1_0.viewGO, "view/common/cost/#btn_cost1/select")
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
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "view/normal")
	arg_1_0._gonormalremain = gohelper.findChild(arg_1_0.viewGO, "view/normal/info/remain")
	arg_1_0._gonormalleftbg = gohelper.findChild(arg_1_0.viewGO, "view/normal/info/remain/#go_leftbg")
	arg_1_0._txtnormalleftremain = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/remain/#go_leftbg/#txt_remain")
	arg_1_0._gonormalrightbg = gohelper.findChild(arg_1_0.viewGO, "view/normal/info/remain/#go_rightbg")
	arg_1_0._txtnormalrightremain = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/remain/#go_rightbg/#txt_remaintime")
	arg_1_0._txtgoodsUseDesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._gonormaldetail = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail")
	arg_1_0._godetailremain = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail/remain")
	arg_1_0._godetailleftbg = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail/remain/#go_leftbg")
	arg_1_0._txtdetailleftremain = gohelper.findChildText(arg_1_0.viewGO, "view/normal_detail/remain/#go_leftbg/#txt_remain")
	arg_1_0._godetailrightbg = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail/remain/#go_rightbg")
	arg_1_0._txtdetailrightremain = gohelper.findChildText(arg_1_0.viewGO, "view/normal_detail/remain/#go_rightbg/#txt_remaintime")
	arg_1_0._gonormaldetailinfo = gohelper.findChild(arg_1_0.viewGO, "view/normal_detail/info")
	arg_1_0._txtnormaldetailUseDesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtnormaldetaildesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._simagetype1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/right/type1")
	arg_1_0._simagetype2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/right/type2")
	arg_1_0._goType3 = gohelper.findChild(arg_1_0.viewGO, "view/right/type3")
	arg_1_0._simagetype3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/right/type3/#simage_icon")
	arg_1_0._gohadnumber = gohelper.findChild(arg_1_0.viewGO, "view/right/type3/#go_hadnumber")
	arg_1_0._txttype3num = gohelper.findChildText(arg_1_0.viewGO, "view/right/type3/#go_hadnumber/#txt_hadnumber")
	arg_1_0._btnicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_click")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btncost1:AddClickListener(arg_2_0._btncost1OnClick, arg_2_0)
	arg_2_0._btncost2:AddClickListener(arg_2_0._btncost2OnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnicon:AddClickListener(arg_2_0._btniconOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btncost1:RemoveClickListener()
	arg_3_0._btncost2:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnicon:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btniconOnClick(arg_5_0)
	local var_5_0 = string.splitToNumber(arg_5_0._goodConfig.product, "#")

	MaterialTipController.instance:showMaterialInfo(var_5_0[1], var_5_0[2])
end

function var_0_0._btncost1OnClick(arg_6_0)
	if DecorateStoreModel.instance:getCurCostIndex() == 1 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(1)
	arg_6_0:_refreshCost()
end

function var_0_0._btncost2OnClick(arg_7_0)
	if DecorateStoreModel.instance:getCurCostIndex() == 2 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(2)
	arg_7_0:_refreshCost()
end

function var_0_0._btnbuyOnClick(arg_8_0)
	if string.nilorempty(arg_8_0._mo.config.cost) and string.nilorempty(arg_8_0._mo.config.cost2) then
		arg_8_0:_buyGood()

		return
	end

	local var_8_0 = DecorateStoreModel.instance:getGoodItemLimitTime(arg_8_0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(arg_8_0._mo.goodsId) or 100

	var_8_0 = var_8_0 == 0 and 100 or var_8_0

	local var_8_1 = DecorateStoreModel.instance:getCurCostIndex()

	if var_8_1 == 1 then
		local var_8_2 = string.splitToNumber(arg_8_0._mo.config.cost, "#")

		arg_8_0._costType = var_8_2[1]
		arg_8_0._costId = var_8_2[2]
		arg_8_0._costQuantity = 0.01 * var_8_0 * var_8_2[3]
	else
		local var_8_3 = string.splitToNumber(arg_8_0._mo.config.cost2, "#")

		arg_8_0._costType = var_8_3[1]
		arg_8_0._costId = var_8_3[2]
		arg_8_0._costQuantity = 0.01 * var_8_0 * var_8_3[3]
	end

	if arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(arg_8_0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_8_0._buyGoods, arg_8_0, arg_8_0.closeThis, arg_8_0) then
			arg_8_0:_buyGood(var_8_1)
		end
	elseif arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(arg_8_0._costQuantity, arg_8_0.closeThis, arg_8_0) then
			arg_8_0:_buyGood(var_8_1)
		end
	elseif arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.OldTravelTicket then
		local var_8_4 = CurrencyModel.instance:getCurrency(arg_8_0._costId)

		if var_8_4 then
			if var_8_4.quantity >= arg_8_0._costQuantity then
				arg_8_0:_buyGood(var_8_1)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(arg_8_0._costType, arg_8_0._costId, arg_8_0._costQuantity) then
		arg_8_0:_buyGood(var_8_1)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, arg_8_0._storeCurrencyNotEnoughCallback, nil, nil, arg_8_0, nil)
	end
end

function var_0_0._storeCurrencyNotEnoughCallback(arg_9_0)
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function var_0_0._buyGood(arg_10_0, arg_10_1)
	StoreController.instance:buyGoods(arg_10_0._mo, 1, arg_10_0._buyCallback, arg_10_0, arg_10_1)
end

function var_0_0._buyCallback(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		arg_11_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.addUIClickAudio(arg_12_0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	DecorateStoreModel.instance:setCurCostIndex(1)
end

function var_0_0._refreshUI(arg_13_0)
	arg_13_0._goodConfig = StoreConfig.instance:getGoodsConfig(arg_13_0._mo.goodsId)
	arg_13_0._curItemType = DecorateStoreModel.getItemType(tonumber(arg_13_0._goodConfig.storeId))

	arg_13_0:_refreshIcon()
	arg_13_0:_refreshGoodDetail()
	arg_13_0:_refreshCost()
end

function var_0_0._refreshIcon(arg_14_0)
	local var_14_0 = DecorateStoreConfig.instance:getDecorateConfig(arg_14_0._mo.goodsId)

	gohelper.setActive(arg_14_0._simagetype1.gameObject, false)
	gohelper.setActive(arg_14_0._simagetype2.gameObject, false)
	gohelper.setActive(arg_14_0._goType3, false)

	if not string.nilorempty(var_14_0.buylmg) then
		local var_14_1 = ResUrl.getDecorateStoreImg(var_14_0.buylmg)

		if arg_14_0._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
			arg_14_0._simagetype2:LoadImage(var_14_1)
			gohelper.setActive(arg_14_0._simagetype2.gameObject, true)
		else
			arg_14_0._simagetype1:LoadImage(var_14_1)
			gohelper.setActive(arg_14_0._simagetype1.gameObject, true)
		end
	else
		local var_14_2 = string.splitToNumber(arg_14_0._goodConfig.product, "#")
		local var_14_3, var_14_4 = ItemModel.instance:getItemConfigAndIcon(var_14_2[1], var_14_2[2], true)
		local var_14_5 = ItemModel.instance:getItemCount(var_14_2[2])

		gohelper.setActive(arg_14_0._goType3, true)
		gohelper.setActive(arg_14_0._gohadnumber, var_14_0.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
		arg_14_0._simagetype3:LoadImage(var_14_4)

		if var_14_0.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut then
			arg_14_0._txttype3num.text = var_14_5
		end
	end
end

function var_0_0._refreshGoodDetail(arg_15_0)
	local var_15_0 = string.splitToNumber(arg_15_0._goodConfig.product, "#")
	local var_15_1 = ItemModel.instance:getItemConfig(var_15_0[1], var_15_0[2])

	arg_15_0._txtgoodsNameCn.text = arg_15_0._mo.config.name

	gohelper.setActive(arg_15_0._gonormal, arg_15_0._curItemType == DecorateStoreEnum.DecorateItemType.Skin)
	gohelper.setActive(arg_15_0._gonormaldetail, arg_15_0._curItemType ~= DecorateStoreEnum.DecorateItemType.Skin)

	if arg_15_0._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
		local var_15_2 = arg_15_0._mo:getOfflineTime()

		if var_15_2 > 0 then
			local var_15_3 = math.floor(var_15_2 - ServerTime.now())

			gohelper.setActive(arg_15_0._gonormalremain, true)

			arg_15_0._txtnormalrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_15_3))
		else
			gohelper.setActive(arg_15_0._gonormalremain, false)
		end

		if arg_15_0._goodConfig.maxBuyCount and arg_15_0._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(arg_15_0._gonormalleftbg, true)

			arg_15_0._txtnormalleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				arg_15_0._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(arg_15_0._gonormalleftbg, false)
		end

		local var_15_4 = SkinConfig.instance:getSkinCo(var_15_0[2])
		local var_15_5 = lua_character.configDict[var_15_4.characterId].name

		arg_15_0._txtgoodsUseDesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), var_15_5)
		arg_15_0._txtgoodsDesc.text = var_15_4.skinDescription
	else
		local var_15_6 = arg_15_0._mo:getOfflineTime()

		if var_15_6 > 0 then
			local var_15_7 = math.floor(var_15_6 - ServerTime.now())

			gohelper.setActive(arg_15_0._godetailrightbg, true)

			arg_15_0._txtdetailrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_15_7))
		else
			gohelper.setActive(arg_15_0._godetailrightbg, false)
		end

		if arg_15_0._goodConfig.maxBuyCount and arg_15_0._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(arg_15_0._godetailleftbg, true)

			arg_15_0._txtdetailleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				arg_15_0._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(arg_15_0._godetailleftbg, false)
		end

		arg_15_0._txtnormaldetailUseDesc.text = var_15_1.useDesc
		arg_15_0._txtnormaldetaildesc.text = var_15_1.desc
	end

	local var_15_8 = arg_15_0._godetailleftbg.gameObject.activeSelf and arg_15_0._godetailrightbg.gameObject.activeSelf

	gohelper.setActive(arg_15_0._godetailremain, var_15_8)
end

function var_0_0._refreshCost(arg_16_0)
	gohelper.setActive(arg_16_0._btncost1, not string.nilorempty(arg_16_0._goodConfig.cost))
	gohelper.setActive(arg_16_0._btncost2, not string.nilorempty(arg_16_0._goodConfig.cost2))

	if string.nilorempty(arg_16_0._goodConfig.cost) then
		gohelper.setActive(arg_16_0._gocost, false)

		return
	end

	gohelper.setActive(arg_16_0._gocost, true)

	local var_16_0 = DecorateStoreModel.instance:getCurCostIndex()
	local var_16_1 = DecorateStoreConfig.instance:getDecorateConfig(arg_16_0._mo.goodsId)
	local var_16_2 = var_16_1.offTag > 0 and var_16_1.offTag or 100

	if var_16_2 > 0 and var_16_2 < 100 then
		gohelper.setActive(arg_16_0._godiscount, true)

		arg_16_0._txtdiscount.text = string.format("-%s%%", var_16_2)
	else
		gohelper.setActive(arg_16_0._godiscount, false)
	end

	local var_16_3 = DecorateStoreModel.instance:getGoodItemLimitTime(arg_16_0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(arg_16_0._mo.goodsId) or 100

	var_16_3 = var_16_3 == 0 and 100 or var_16_3

	if var_16_3 > 0 and var_16_3 < 100 then
		gohelper.setActive(arg_16_0._godiscount, false)
		gohelper.setActive(arg_16_0._godiscount2, true)

		arg_16_0._txtdiscount2.text = string.format("-%s%%", var_16_3)
	else
		gohelper.setActive(arg_16_0._godiscount2, false)
	end

	local var_16_4 = DecorateStoreModel.instance:getGoodItemLimitTime(arg_16_0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(arg_16_0._mo.goodsId) or 100

	var_16_4 = var_16_4 == 0 and 100 or var_16_4

	local var_16_5 = string.splitToNumber(arg_16_0._goodConfig.cost, "#")

	if string.nilorempty(arg_16_0._mo.config.cost2) then
		gohelper.setActive(arg_16_0._gocost, false)
		gohelper.setActive(arg_16_0._gocostsingle, true)

		local var_16_6, var_16_7 = ItemModel.instance:getItemConfigAndIcon(var_16_5[1], var_16_5[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconsingle, var_16_6.icon .. "_1", true)

		if ItemModel.instance:getItemQuantity(var_16_5[1], var_16_5[2]) >= var_16_5[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpricesingle, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpricesingle, "#bf2e11")
		end

		arg_16_0._txtcurpricesingle.text = 0.01 * var_16_4 * var_16_5[3]

		if var_16_1.originalCost1 > 0 then
			gohelper.setActive(arg_16_0._txtoriginalpricesingle.gameObject, true)

			arg_16_0._txtoriginalpricesingle.text = var_16_1.originalCost1
		else
			gohelper.setActive(arg_16_0._txtoriginalpricesingle.gameObject, false)
		end
	else
		gohelper.setActive(arg_16_0._gocost, true)
		gohelper.setActive(arg_16_0._gocostsingle, false)

		local var_16_8, var_16_9 = ItemModel.instance:getItemConfigAndIcon(var_16_5[1], var_16_5[2])

		arg_16_0._txtcurpriceunselect1.text = 0.01 * var_16_4 * var_16_5[3]
		arg_16_0._txtcurpriceselect1.text = 0.01 * var_16_4 * var_16_5[3]

		if ItemModel.instance:getItemQuantity(var_16_5[1], var_16_5[2]) >= var_16_5[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect1, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect1, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect1, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect1, "#bf2e11")
		end

		if var_16_1.originalCost1 > 0 then
			gohelper.setActive(arg_16_0._txtoriginalpriceselect1.gameObject, true)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect1.gameObject, true)

			arg_16_0._txtoriginalpriceselect1.text = var_16_1.originalCost1
			arg_16_0._txtoriginalpriceunselect1.text = var_16_1.originalCost1
		else
			gohelper.setActive(arg_16_0._txtoriginalpriceselect1.gameObject, false)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect1.gameObject, false)
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconselect1, var_16_8.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconunselect1, var_16_8.icon .. "_1", true)
		gohelper.setActive(arg_16_0._goselect1, var_16_0 == 1)
		gohelper.setActive(arg_16_0._gounselect1, var_16_0 ~= 1)

		if string.nilorempty(arg_16_0._goodConfig.cost2) then
			gohelper.setActive(arg_16_0._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect2.gameObject, false)

			return
		end

		local var_16_10 = string.splitToNumber(arg_16_0._goodConfig.cost2, "#")
		local var_16_11, var_16_12 = ItemModel.instance:getItemConfigAndIcon(var_16_10[1], var_16_10[2])

		arg_16_0._txtcurpriceunselect2.text = 0.01 * var_16_4 * var_16_10[3]
		arg_16_0._txtcurpriceselect2.text = 0.01 * var_16_4 * var_16_10[3]

		if ItemModel.instance:getItemQuantity(var_16_10[1], var_16_10[2]) >= var_16_10[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect2, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect2, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect2, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect2, "#bf2e11")
		end

		if var_16_1.originalCost2 > 0 then
			gohelper.setActive(arg_16_0._txtoriginalpriceselect2.gameObject, true)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect2.gameObject, true)

			arg_16_0._txtoriginalpriceselect2.text = var_16_1.originalCost2
			arg_16_0._txtoriginalpriceunselect2.text = var_16_1.originalCost2
		else
			gohelper.setActive(arg_16_0._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect2.gameObject, false)
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconselect2, var_16_11.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconunselect2, var_16_11.icon .. "_1", true)
		gohelper.setActive(arg_16_0._goselect2, var_16_0 == 2)
		gohelper.setActive(arg_16_0._gounselect2, var_16_0 ~= 2)
	end
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._mo = arg_17_0.viewParam

	arg_17_0:_setCurrency()
	arg_17_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	StoreController.instance:statOpenChargeGoods(arg_17_0._mo.belongStoreId, arg_17_0._mo.config)
end

function var_0_0._setCurrency(arg_18_0)
	local var_18_0 = {}

	if arg_18_0._mo.config.cost ~= "" then
		local var_18_1 = string.splitToNumber(arg_18_0._mo.config.cost, "#")

		table.insert(var_18_0, var_18_1[2])
	end

	if arg_18_0._mo.config.cost2 ~= "" then
		local var_18_2 = string.splitToNumber(arg_18_0._mo.config.cost2, "#")

		table.insert(var_18_0, var_18_2[2])
	end

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if iter_18_1 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(var_18_0, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local var_18_3 = LuaUtil.getReverseArrTab(var_18_0)

	arg_18_0.viewContainer:setCurrencyType(var_18_3)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0._mo = arg_20_0.viewParam

	arg_20_0:_refreshUI()
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagetype1:UnLoadImage()
	arg_21_0._simagetype2:UnLoadImage()
end

return var_0_0
