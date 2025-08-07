module("modules.logic.room.view.gift.RoomBlockGiftStoreGoodsView", package.seeall)

local var_0_0 = class("RoomBlockGiftStoreGoodsView", BaseView)

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
	arg_1_0._simagetype1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/right/type1/#simage_icon")
	arg_1_0._gohadnumber = gohelper.findChild(arg_1_0.viewGO, "view/right/type1/#go_hadnumber")
	arg_1_0._txttype1num = gohelper.findChildText(arg_1_0.viewGO, "view/right/type1/#go_hadnumber/#txt_hadnumber")
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
	if arg_6_0._curSelectCostIndex == 1 then
		return
	end

	arg_6_0._curSelectCostIndex = 1

	arg_6_0:_refreshCost()
end

function var_0_0._btncost2OnClick(arg_7_0)
	if arg_7_0._curSelectCostIndex == 2 then
		return
	end

	arg_7_0._curSelectCostIndex = 2

	arg_7_0:_refreshCost()
end

function var_0_0._btnbuyOnClick(arg_8_0)
	if string.nilorempty(arg_8_0._mo.config.cost) and string.nilorempty(arg_8_0._mo.config.cost2) then
		arg_8_0:_buyGood()

		return
	end

	if arg_8_0._curSelectCostIndex == 1 then
		local var_8_0 = string.splitToNumber(arg_8_0._mo.config.cost, "#")

		arg_8_0._costType = var_8_0[1]
		arg_8_0._costId = var_8_0[2]
		arg_8_0._costQuantity = var_8_0[3]
	else
		local var_8_1 = string.splitToNumber(arg_8_0._mo.config.cost2, "#")

		arg_8_0._costType = var_8_1[1]
		arg_8_0._costId = var_8_1[2]
		arg_8_0._costQuantity = var_8_1[3]
	end

	if arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(arg_8_0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_8_0._buyGood, arg_8_0, arg_8_0.closeThis, arg_8_0) then
			arg_8_0:_buyGood(arg_8_0._curSelectCostIndex)
		end
	elseif arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(arg_8_0._costQuantity, arg_8_0.closeThis, arg_8_0) then
			arg_8_0:_buyGood(arg_8_0._curSelectCostIndex)
		end
	elseif arg_8_0._costType == MaterialEnum.MaterialType.Currency and arg_8_0._costId == CurrencyEnum.CurrencyType.OldTravelTicket then
		local var_8_2 = CurrencyModel.instance:getCurrency(arg_8_0._costId)

		if var_8_2 then
			if var_8_2.quantity >= arg_8_0._costQuantity then
				arg_8_0:_buyGood(arg_8_0._curSelectCostIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(arg_8_0._costType, arg_8_0._costId, arg_8_0._costQuantity) then
		arg_8_0:_buyGood(arg_8_0._curSelectCostIndex)
	else
		local var_8_3, var_8_4 = ItemModel.instance:getItemConfigAndIcon(arg_8_0._costType, arg_8_0._costId)

		if var_8_3 then
			GameFacade.showToast(ToastEnum.ClickRoomStoreInsight, var_8_3.name)
		end
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

	arg_12_0._curSelectCostIndex = 1

	gohelper.setActive(arg_12_0._txtoriginalpriceunselect1.gameObject, false)
	gohelper.setActive(arg_12_0._txtoriginalpriceselect1.gameObject, false)
	gohelper.setActive(arg_12_0._txtoriginalpriceunselect2.gameObject, false)
	gohelper.setActive(arg_12_0._txtoriginalpriceselect2.gameObject, false)
end

function var_0_0._refreshUI(arg_13_0)
	arg_13_0._goodConfig = StoreConfig.instance:getGoodsConfig(arg_13_0._mo.goodsId)

	arg_13_0:_refreshIcon()
	arg_13_0:_refreshGoodDetail()
	arg_13_0:_refreshCost()
end

function var_0_0._refreshIcon(arg_14_0)
	local var_14_0 = string.splitToNumber(arg_14_0._goodConfig.product, "#")
	local var_14_1, var_14_2 = ItemModel.instance:getItemConfigAndIcon(var_14_0[1], var_14_0[2], true)
	local var_14_3 = ItemModel.instance:getItemCount(var_14_0[2])

	arg_14_0._simagetype1:LoadImage(var_14_2)

	arg_14_0._txttype1num.text = var_14_3
end

function var_0_0._refreshGoodDetail(arg_15_0)
	local var_15_0 = string.splitToNumber(arg_15_0._goodConfig.product, "#")
	local var_15_1 = ItemModel.instance:getItemConfig(var_15_0[1], var_15_0[2])

	arg_15_0._txtgoodsNameCn.text = arg_15_0._mo.config.name
	arg_15_0._txtnormaldetailUseDesc.text = var_15_1.useDesc
	arg_15_0._txtnormaldetaildesc.text = var_15_1.desc

	local var_15_2 = arg_15_0._mo:getOfflineTime()

	if var_15_2 > 0 then
		local var_15_3 = math.floor(var_15_2 - ServerTime.now())

		gohelper.setActive(arg_15_0._godetailrightbg, true)

		arg_15_0._txtdetailrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_15_3))
	else
		gohelper.setActive(arg_15_0._godetailrightbg, false)
	end

	if arg_15_0._goodConfig.maxBuyCount and arg_15_0._goodConfig.maxBuyCount > 0 then
		gohelper.setActive(arg_15_0._godetailleftbg, true)

		local var_15_4 = arg_15_0._goodConfig.maxBuyCount - arg_15_0._mo.buyCount

		arg_15_0._txtdetailleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
			var_15_4
		})
	else
		gohelper.setActive(arg_15_0._godetailleftbg, false)
	end

	gohelper.setActive(arg_15_0._gonormaldetail, true)
end

function var_0_0._refreshCost(arg_16_0)
	gohelper.setActive(arg_16_0._btncost1, not string.nilorempty(arg_16_0._goodConfig.cost))
	gohelper.setActive(arg_16_0._btncost2, not string.nilorempty(arg_16_0._goodConfig.cost2))

	if string.nilorempty(arg_16_0._goodConfig.cost) then
		gohelper.setActive(arg_16_0._gocost, false)

		return
	end

	local var_16_0 = string.splitToNumber(arg_16_0._mo.config.cost, "#")

	gohelper.setActive(arg_16_0._gocost, true)

	if string.nilorempty(arg_16_0._mo.config.cost2) then
		gohelper.setActive(arg_16_0._gocost, false)
		gohelper.setActive(arg_16_0._gocostsingle, true)

		local var_16_1, var_16_2 = ItemModel.instance:getItemConfigAndIcon(var_16_0[1], var_16_0[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconsingle, var_16_1.icon .. "_1", true)

		if ItemModel.instance:getItemQuantity(var_16_0[1], var_16_0[2]) >= var_16_0[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpricesingle, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpricesingle, "#bf2e11")
		end

		arg_16_0._txtcurpricesingle.text = var_16_0[3]
	else
		gohelper.setActive(arg_16_0._gocost, true)
		gohelper.setActive(arg_16_0._gocostsingle, false)

		local var_16_3, var_16_4 = ItemModel.instance:getItemConfigAndIcon(var_16_0[1], var_16_0[2])

		arg_16_0._txtcurpriceunselect1.text = var_16_0[3]
		arg_16_0._txtcurpriceselect1.text = var_16_0[3]

		if ItemModel.instance:getItemQuantity(var_16_0[1], var_16_0[2]) >= var_16_0[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect1, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect1, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect1, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect1, "#bf2e11")
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconselect1, var_16_3.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconunselect1, var_16_3.icon .. "_1", true)
		gohelper.setActive(arg_16_0._goselect1, arg_16_0._curSelectCostIndex == 1)
		gohelper.setActive(arg_16_0._gounselect1, arg_16_0._curSelectCostIndex ~= 1)

		if string.nilorempty(arg_16_0._goodConfig.cost2) then
			gohelper.setActive(arg_16_0._txtoriginalpriceselect2.gameObject, false)
			gohelper.setActive(arg_16_0._txtoriginalpriceunselect2.gameObject, false)

			return
		end

		local var_16_5 = string.splitToNumber(arg_16_0._goodConfig.cost2, "#")
		local var_16_6, var_16_7 = ItemModel.instance:getItemConfigAndIcon(var_16_5[1], var_16_5[2])

		arg_16_0._txtcurpriceunselect2.text = var_16_5[3]
		arg_16_0._txtcurpriceselect2.text = var_16_5[3]

		if ItemModel.instance:getItemQuantity(var_16_5[1], var_16_5[2]) >= var_16_5[3] then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect2, "#393939")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect2, "#ffffff")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceunselect2, "#bf2e11")
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtcurpriceselect2, "#bf2e11")
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconselect2, var_16_6.icon .. "_1", true)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imageiconunselect2, var_16_6.icon .. "_1", true)
		gohelper.setActive(arg_16_0._goselect2, arg_16_0._curSelectCostIndex == 2)
		gohelper.setActive(arg_16_0._gounselect2, arg_16_0._curSelectCostIndex ~= 2)
	end
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._mo = arg_17_0.viewParam

	arg_17_0:_setCurrency()
	arg_17_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
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
end

return var_0_0
