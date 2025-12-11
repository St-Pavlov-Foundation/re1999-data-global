module("modules.logic.store.view.DecorateStoreGoodsBuyView", package.seeall)

local var_0_0 = class("DecorateStoreGoodsBuyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_theme")
	arg_1_0._txttheme = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_theme/txt")
	arg_1_0._gocobrand = gohelper.findChild(arg_1_0.viewGO, "left/#go_cobrand")
	arg_1_0._gobuyContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent")
	arg_1_0._goblockInfoItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change")
	arg_1_0._txtchange = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	arg_1_0._imagechangeicon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	arg_1_0._gopaynoraml = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	arg_1_0._gopayselect = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	arg_1_0._btnticket = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	arg_1_0._gopay = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay")
	arg_1_0._gopayitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	arg_1_0._imagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "right/#go_source")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnticket:AddClickListener(arg_2_0._btnClickUseTicket, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntheme:RemoveClickListener()
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnticket:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnthemeOnClick(arg_4_0)
	return
end

function var_0_0._btninsightOnClick(arg_5_0)
	local var_5_0 = DecorateStoreModel.instance:getCurCostIndex()
	local var_5_1 = arg_5_0._currencyParam[var_5_0]

	if var_5_1[1] == MaterialEnum.MaterialType.Currency and var_5_1[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(var_5_1[3], CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_5_0._buyGood, arg_5_0, arg_5_0.closeThis, arg_5_0) then
			arg_5_0:_buyGood(var_5_0)
		end
	elseif var_5_1[1] == MaterialEnum.MaterialType.Currency and var_5_1[2] == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(var_5_1[3], arg_5_0.closeThis, arg_5_0) then
			arg_5_0:_buyGood(var_5_0)
		end
	elseif var_5_1[1] == MaterialEnum.MaterialType.Currency and var_5_1[2] == CurrencyEnum.CurrencyType.OldTravelTicket then
		local var_5_2 = CurrencyModel.instance:getCurrency(var_5_1[2])

		if var_5_2 then
			if var_5_2.quantity >= var_5_1[3] then
				arg_5_0:_buyGood(var_5_0)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(var_5_1[1], var_5_1[2], var_5_1[3]) then
		arg_5_0:_buyGood(var_5_0)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, arg_5_0._storeCurrencyNotEnoughCallback, nil, nil, arg_5_0, nil)
	end
end

function var_0_0._storeCurrencyNotEnoughCallback(arg_6_0)
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function var_0_0._buyGood(arg_7_0, arg_7_1)
	StoreController.instance:buyGoods(arg_7_0._mo, 1, arg_7_0._buyCallback, arg_7_0, arg_7_1)
end

function var_0_0._buyCallback(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == 0 then
		arg_8_0:closeThis()
	end
end

function var_0_0._btnClickUseTicket(arg_9_0)
	return
end

function var_0_0._btncloseOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._simagetheme = gohelper.findChildSingleImage(arg_11_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/iconmask/simage_theme")
	arg_11_0._goitemContent = gohelper.findChildSingleImage(arg_11_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/go_itemContent")
	arg_11_0._simageinfobg = gohelper.findChildSingleImage(arg_11_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/simage_infobg")
	arg_11_0._txtdesc = gohelper.findChildText(arg_11_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc")
	arg_11_0._txtname = gohelper.findChildText(arg_11_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/txt_desc/txt_name")
	arg_11_0._goslider = gohelper.findChild(arg_11_0.viewGO, "left/banner/#go_slider")
	arg_11_0._payItemTbList = {}
	arg_11_0._infoItemTbList = {}

	gohelper.setActive(arg_11_0._goblockInfoItem, false)
	gohelper.setActive(arg_11_0._btntheme.gameObject, false)
	gohelper.setActive(arg_11_0._goitemContent.gameObject, false)
	gohelper.setActive(arg_11_0._goslider.gameObject, false)
	gohelper.setActive(arg_11_0._gobuyContent, true)
	gohelper.setActive(arg_11_0._gosource, false)
	arg_11_0:_createPayItemUserDataTb_(arg_11_0._gopayitem, 1)
	arg_11_0:_createInfoItemUserDataTb_(arg_11_0._goblockInfoItem, 1)
	arg_11_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_11_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.removeUIClickAudio(arg_11_0._btnclose.gameObject)
	gohelper.addUIClickAudio(arg_11_0._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	arg_11_0._simageinfobg:LoadImage(ResUrl.getRoomImage("bg_zhezhao_yinying"))
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._mo = arg_12_0.viewParam.goodsMo

	DecorateStoreModel.instance:setCurCostIndex(1)
	arg_12_0:_setCurrency()
	arg_12_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	StoreController.instance:statOpenChargeGoods(arg_12_0._mo.belongStoreId, arg_12_0._mo.config)
end

function var_0_0._setCurrency(arg_13_0)
	local var_13_0 = {}

	arg_13_0._currencyParam = {}

	if arg_13_0._mo.config.cost ~= "" then
		local var_13_1 = string.splitToNumber(arg_13_0._mo.config.cost, "#")

		table.insert(var_13_0, var_13_1[2])
		table.insert(arg_13_0._currencyParam, var_13_1)
	end

	if arg_13_0._mo.config.cost2 ~= "" then
		local var_13_2 = string.splitToNumber(arg_13_0._mo.config.cost2, "#")

		table.insert(var_13_0, var_13_2[2])
		table.insert(arg_13_0._currencyParam, var_13_2)
	end

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if iter_13_1 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(var_13_0, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local var_13_3 = LuaUtil.getReverseArrTab(var_13_0)

	arg_13_0.viewContainer:setCurrencyType(var_13_3)
end

function var_0_0._refreshUI(arg_14_0)
	arg_14_0._goodConfig = StoreConfig.instance:getGoodsConfig(arg_14_0._mo.goodsId)
	arg_14_0._curItemType = DecorateStoreModel.getItemType(tonumber(arg_14_0._goodConfig.storeId))
	arg_14_0._products = string.splitToNumber(arg_14_0._goodConfig.product, "#")
	arg_14_0._itemCo = ItemModel.instance:getItemConfig(arg_14_0._products[1], arg_14_0._products[2])

	arg_14_0:_refreshIcon()
	arg_14_0:_refreshCost()
	arg_14_0._simagetheme:LoadImage(ResUrl.getDecorateStoreBuyBannerFullPath(arg_14_0._itemCo.id), function()
		ZProj.UGUIHelper.SetImageSize(arg_14_0._simagetheme.gameObject)
	end, arg_14_0)

	arg_14_0._txtdesc.text = arg_14_0._itemCo.desc
	arg_14_0._txtname.text = arg_14_0._itemCo.name
end

function var_0_0._createPayItemUserDataTb_(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0._go = arg_16_1
	var_16_0._index = arg_16_2
	var_16_0._gonormalbg = gohelper.findChild(arg_16_1, "go_normalbg")
	var_16_0._goselectbg = gohelper.findChild(arg_16_1, "go_selectbg")
	var_16_0._imageicon = gohelper.findChildImage(arg_16_1, "txt_desc/simage_icon")
	var_16_0._txtdesc = gohelper.findChildText(arg_16_1, "txt_desc")
	var_16_0._btnpay = gohelper.findChildButtonWithAudio(arg_16_1, "btn_pay")

	var_16_0._btnpay:AddClickListener(arg_16_0._onClickPlay, arg_16_0, arg_16_2)
	table.insert(arg_16_0._payItemTbList, var_16_0)

	return var_16_0
end

function var_0_0._onClickPlay(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._payItemTbList) do
		arg_17_0:_onSelectPayItemUI(iter_17_1, iter_17_1._index == arg_17_1)
	end

	DecorateStoreModel.instance:setCurCostIndex(arg_17_1)
	arg_17_0:_refreshCost()
end

function var_0_0._createInfoItemUserDataTb_(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getUserDataTb_()

	var_18_0._go = arg_18_1
	var_18_0._index = arg_18_2
	var_18_0._goeprice = gohelper.findChild(arg_18_1, "go_price")
	var_18_0._gofinish = gohelper.findChild(arg_18_1, "go_finish")
	var_18_0._txtgold = gohelper.findChildText(arg_18_1, "go_price/txt_gold")
	var_18_0._imagegold = gohelper.findChildImage(arg_18_1, "go_price/image_gold")
	var_18_0._txtname = gohelper.findChildText(arg_18_1, "txt_name")
	var_18_0._txtnum = gohelper.findChildText(arg_18_1, "txt_num")
	var_18_0._gobg = gohelper.findChild(arg_18_1, "go_bg")
	var_18_0._txtowner = gohelper.findChildText(arg_18_1, "go_finish/txt_owner")

	table.insert(arg_18_0._infoItemTbList, var_18_0)

	return var_18_0
end

function var_0_0._refreshPayItemUI(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_1.costId = arg_19_2

	local var_19_0 = arg_19_0:_getCurrencyIconStr(arg_19_3, arg_19_4)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_1._imageicon, var_19_0)

	local var_19_1, var_19_2 = ItemModel.instance:getItemConfigAndIcon(arg_19_3, arg_19_4, true)

	arg_19_1._txtdesc.text = var_19_1 and var_19_1.name or nil
end

function var_0_0._getCurrencyIconStr(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = 0

	if string.len(arg_20_2) == 1 then
		var_20_0 = arg_20_1 .. "0" .. arg_20_2
	else
		var_20_0 = arg_20_1 .. arg_20_2
	end

	return string.format("%s_1", var_20_0)
end

function var_0_0._onSelectPayItemUI(arg_21_0, arg_21_1, arg_21_2)
	gohelper.setActive(arg_21_1._goselectbg, arg_21_2)
	gohelper.setActive(arg_21_1._gonormalbg, not arg_21_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_21_1._txtdesc, arg_21_2 and "#FFFFFF" or "#4C4341")
end

function var_0_0._refreshIcon(arg_22_0)
	local var_22_0 = DecorateStoreModel.instance:getCurCostIndex()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._currencyParam) do
		local var_22_1 = arg_22_0._payItemTbList[iter_22_0]

		if not var_22_1 then
			local var_22_2 = gohelper.cloneInPlace(arg_22_0._gopayitem, "go_payitem" .. iter_22_0)

			var_22_1 = arg_22_0:_createPayItemUserDataTb_(var_22_2, iter_22_0)
		end

		arg_22_0:_onSelectPayItemUI(var_22_1, var_22_1._index == var_22_0)
		gohelper.setActive(var_22_1._go, true)
		arg_22_0:_refreshPayItemUI(var_22_1, iter_22_0, iter_22_1[1], iter_22_1[2])
	end
end

function var_0_0._refreshCost(arg_23_0)
	local var_23_0 = DecorateStoreModel.instance:getCurCostIndex()
	local var_23_1 = arg_23_0._currencyParam[var_23_0]

	if var_23_1 then
		local var_23_2 = arg_23_0:_getCurrencyIconStr(var_23_1[1], var_23_1[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imagecosticon, var_23_2)

		local var_23_3 = ItemModel.instance:getItemQuantity(var_23_1[1], var_23_1[2])

		SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._txtcostnum, var_23_3 and var_23_3 >= var_23_1[3] and "#595959" or "#BF2E11")

		arg_23_0._txtcostnum.text = var_23_1[3]

		local var_23_4 = arg_23_0._infoItemTbList[1]

		if not var_23_4 then
			local var_23_5 = gohelper.cloneInPlace(arg_23_0._goblockInfoItem, "go_payitem" .. var_23_0)

			var_23_4 = arg_23_0:_createInfoItemUserDataTb_(var_23_5, var_23_0)
		end

		var_23_4._txtname.text = arg_23_0._goodConfig.name

		local var_23_6 = ItemModel.instance:getItemQuantity(arg_23_0._products[1], arg_23_0._products[2])

		var_23_4._txtnum.text = string.format("%s/%s", var_23_6, arg_23_0._products[3])
		var_23_4._txtgold.text = var_23_1[3]

		UISpriteSetMgr.instance:setCurrencyItemSprite(var_23_4._imagegold, var_23_2)
		gohelper.setActive(var_23_4._go, true)
	else
		logError("消耗货币数据出错")
	end
end

function var_0_0.onClickModalMask(arg_24_0)
	arg_24_0:closeThis()
end

function var_0_0.onClose(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._payItemTbList) do
		iter_25_1._btnpay:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simagebg1:UnLoadImage()
	arg_26_0._simagebg2:UnLoadImage()
	arg_26_0._simagetheme:UnLoadImage()
	arg_26_0._simageinfobg:UnLoadImage()
end

return var_0_0
