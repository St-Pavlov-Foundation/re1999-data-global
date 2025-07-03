module("modules.logic.room.view.critter.train.RoomCritterExchangeView", package.seeall)

local var_0_0 = class("RoomCritterExchangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_leftbg")
	arg_1_0._txtleftproductname = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_leftproductname")
	arg_1_0._simageleftproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_leftproduct")
	arg_1_0._txtrightproductname = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_rightproductname")
	arg_1_0._simagerightproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#simage_rightproduct")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "#go_buy")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_buy/#txt_count")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_buy/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_buy")
	arg_1_0._gobuylimit = gohelper.findChild(arg_1_0.viewGO, "#go_buy/#go_buylimit")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_buy/cost")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_buy/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "#go_buy/cost/#txt_originalCost")
	arg_1_0._txtoriginalCost2 = gohelper.findChildText(arg_1_0.viewGO, "#go_buy/cost/#txt_originalCost2")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

local var_0_1 = 99

function var_0_0._btnminOnClick(arg_4_0)
	arg_4_0._buyCount = 1

	arg_4_0:_refreshUI()
end

function var_0_0._btnsubOnClick(arg_5_0)
	if arg_5_0._buyCount < 1 then
		return
	end

	arg_5_0._buyCount = arg_5_0._buyCount - 1

	arg_5_0:_refreshUI()
end

function var_0_0._btnaddOnClick(arg_6_0)
	if arg_6_0._buyCount >= arg_6_0._maxBuyCount then
		return
	end

	arg_6_0._buyCount = arg_6_0._buyCount + 1

	arg_6_0:_refreshUI()
end

function var_0_0._btnmaxOnClick(arg_7_0)
	arg_7_0._buyCount = arg_7_0._maxBuyCount

	arg_7_0:_refreshUI()
end

function var_0_0._btnbuyOnClick(arg_8_0)
	local var_8_0 = RoomTrainCritterModel.instance:getProductGood(arg_8_0.viewParam[2])
	local var_8_1 = string.splitToNumber(var_8_0.config.cost, "#")
	local var_8_2 = ItemModel.instance:getItemConfig(var_8_1[1], var_8_1[2])

	if arg_8_0:getOwnCount() < arg_8_0._buyCount then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNotEnoughCurrency, var_8_2.name)

		return
	end

	StoreController.instance:buyGoods(var_8_0, arg_8_0._buyCount, arg_8_0._buyCallback, arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._onInputCountValueChanged(arg_11_0)
	arg_11_0:_checkRefreshInputAmount()
end

function var_0_0._onInputCountEndEdit(arg_12_0)
	arg_12_0:_checkRefreshInputAmount()
end

function var_0_0._checkRefreshInputAmount(arg_13_0)
	local var_13_0 = tonumber(arg_13_0._inputvalue:GetText()) or 0

	var_13_0 = var_13_0 > arg_13_0._maxBuyCount and arg_13_0._maxBuyCount or var_13_0
	arg_13_0._buyCount = var_13_0

	arg_13_0:_refreshUI()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)
	arg_14_0._inputText = arg_14_0._inputvalue.inputField.textComponent
	arg_14_0._buyCount = 1
end

function var_0_0._refreshUI(arg_15_0)
	arg_15_0._inputvalue:SetText(arg_15_0._buyCount)

	local var_15_0 = RoomTrainCritterModel.instance:getProductGood(arg_15_0.viewParam[2])

	if not var_15_0 then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	local var_15_1 = var_15_0.config.maxBuyCount - var_15_0.buyCount
	local var_15_2 = string.splitToNumber(var_15_0.config.cost, "#")
	local var_15_3 = arg_15_0:getOwnCount()
	local var_15_4 = StoreConfig.instance:getRemain(var_15_0.config, var_15_1, var_15_0.offlineTime)

	if string.nilorempty(var_15_4) then
		gohelper.setActive(arg_15_0._txtcount.gameObject, false)

		arg_15_0._maxBuyCount = var_15_3 > var_0_1 and var_0_1 or var_15_3
	else
		gohelper.setActive(arg_15_0._txtcount.gameObject, true)

		arg_15_0._txtcount.text = var_15_4 .. "/" .. var_15_0.config.maxBuyCount
		arg_15_0._maxBuyCount = var_15_1
	end

	if var_15_3 == 0 then
		arg_15_0._maxBuyCount = 1
	end

	gohelper.setActive(arg_15_0._gobuylimit, arg_15_0._buyCount <= 0)
	gohelper.setActive(arg_15_0._btnbuy.gameObject, arg_15_0._buyCount > 0)
	gohelper.setActive(arg_15_0._gocost, arg_15_0._buyCount > 0)

	if arg_15_0._buyCount > 0 then
		if string.nilorempty(var_15_0.config.cost) then
			gohelper.setActive(arg_15_0._txtoriginalCost.gameObject, false)
		else
			gohelper.setActive(arg_15_0._txtoriginalCost.gameObject, true)

			arg_15_0._txtoriginalCost.text = arg_15_0._buyCount * var_15_2[3]
		end

		if var_15_0.config.originalCost > 0 then
			gohelper.setActive(arg_15_0._txtoriginalCost2.gameObject, true)

			arg_15_0._txtoriginalCost2.text = arg_15_0._buyCount * var_15_0.config.originalCost
		else
			gohelper.setActive(arg_15_0._txtoriginalCost2.gameObject, false)
		end
	end

	local var_15_5 = var_15_3 >= arg_15_0._buyCount and arg_15_0._colorDefault or Color.red

	arg_15_0._inputText.color = var_15_5
end

function var_0_0.getOwnCount(arg_16_0)
	local var_16_0 = RoomTrainCritterModel.instance:getProductGood(arg_16_0.viewParam[2])
	local var_16_1 = string.splitToNumber(var_16_0.config.cost, "#")
	local var_16_2 = ItemModel.instance:getItemQuantity(var_16_1[1], var_16_1[2])

	return math.floor(var_16_2 / var_16_1[3])
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:_initIcon()
	arg_18_0:_refreshUI()
	arg_18_0._inputvalue:AddOnValueChanged(arg_18_0._onInputCountValueChanged, arg_18_0)
	arg_18_0._inputvalue:AddOnEndEdit(arg_18_0._onInputCountEndEdit, arg_18_0)
end

function var_0_0._initIcon(arg_19_0)
	local var_19_0 = RoomTrainCritterModel.instance:getProductGood(arg_19_0.viewParam[2])

	if not var_19_0 then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	local var_19_1 = string.splitToNumber(var_19_0.config.product, "#")
	local var_19_2, var_19_3 = ItemModel.instance:getItemConfigAndIcon(var_19_1[1], var_19_1[2], true)

	gohelper.setActive(arg_19_0._simagerightproduct.gameObject, true)
	arg_19_0._simagerightproduct:LoadImage(var_19_3)

	arg_19_0._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_critter_exchange"), {
		var_19_2.name,
		var_19_1[3]
	})

	local var_19_4 = string.splitToNumber(var_19_0.config.cost, "#")
	local var_19_5, var_19_6 = ItemModel.instance:getItemConfigAndIcon(var_19_4[1], var_19_4[2], true)

	gohelper.setActive(arg_19_0._simageleftproduct.gameObject, true)
	arg_19_0._simageleftproduct:LoadImage(var_19_6)

	arg_19_0._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("room_critter_exchange"), {
		var_19_5.name,
		var_19_4[3]
	})

	arg_19_0._simagecosticon:LoadImage(var_19_6)

	local var_19_7 = {}

	table.insert(var_19_7, var_19_1[2])
	table.insert(var_19_7, var_19_4[2])
	arg_19_0.viewContainer:setCurrencyType(var_19_7)
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._inputvalue:RemoveOnValueChanged()
	arg_21_0._inputvalue:RemoveOnEndEdit()
	arg_21_0._simageleftbg:UnLoadImage()
	arg_21_0._simagerightbg:UnLoadImage()
	arg_21_0._simageleftproduct:UnLoadImage()
	arg_21_0._simagerightproduct:UnLoadImage()
end

return var_0_0
