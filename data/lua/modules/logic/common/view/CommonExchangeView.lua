module("modules.logic.common.view.CommonExchangeView", package.seeall)

local var_0_0 = class("CommonExchangeView", BaseView)
local var_0_1 = "#E7E4E4"
local var_0_2 = "#FF0000"
local var_0_3 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_leftbg")
	arg_1_0._txtleftproductname = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_leftproductname")
	arg_1_0._simageleftproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_leftproduct")
	arg_1_0._txtrightproductname = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_rightproductname")
	arg_1_0._simagerightproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#simage_rightproduct")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "#go_buy")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_buy/valuebg/#input_value")
	arg_1_0._inputText = arg_1_0._inputvalue.inputField.textComponent
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_buy")
	arg_1_0._gobuylimit = gohelper.findChild(arg_1_0.viewGO, "#go_buy/#go_buylimit")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_buy/cost")
	arg_1_0._simagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "#go_buy/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "#go_buy/cost/#txt_originalCost")
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
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0._onInputChangeExchangeTimesValue, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnValueChanged()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onCurrencyChange, arg_3_0)
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
end

function var_0_0._btnminOnClick(arg_4_0)
	arg_4_0:changeExchangeTimes(var_0_3)
end

function var_0_0._btnsubOnClick(arg_5_0)
	arg_5_0:changeExchangeTimes(arg_5_0.exchangeTimes - 1)
end

function var_0_0._btnaddOnClick(arg_6_0)
	arg_6_0:changeExchangeTimes(arg_6_0.exchangeTimes + 1)
end

function var_0_0._btnmaxOnClick(arg_7_0)
	local var_7_0 = arg_7_0:getMaxExchangeTimes()

	arg_7_0:changeExchangeTimes(var_7_0)
end

function var_0_0._onInputChangeExchangeTimesValue(arg_8_0, arg_8_1)
	local var_8_0 = tonumber(arg_8_1)

	if not var_8_0 then
		return
	end

	arg_8_0:changeExchangeTimes(var_8_0)
end

function var_0_0._btnbuyOnClick(arg_9_0)
	if not arg_9_0._exchangeFunc then
		logError("CommonExchangeView._btnbuyOnClick error, no _exchangeFunc")

		return
	end

	arg_9_0._exchangeFunc(arg_9_0._exchangeFuncObj, arg_9_0.exchangeTimes, arg_9_0._afterExchange, arg_9_0)
end

function var_0_0._afterExchange(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 and arg_10_2 ~= 0 then
		return
	end

	arg_10_0:_btncloseOnClick()
end

function var_0_0._btncloseOnClick(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onClickModalMask(arg_12_0)
	arg_12_0:_btncloseOnClick()
end

function var_0_0._onCurrencyChange(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.costMatData and arg_13_0.costMatData.materilType == MaterialEnum.MaterialType.Currency
	local var_13_1 = arg_13_0.targetMatData and arg_13_0.targetMatData.materilType == MaterialEnum.MaterialType.Currency

	if var_13_0 or var_13_1 then
		arg_13_0:refreshUI()
	end
end

function var_0_0._onItemChanged(arg_14_0)
	arg_14_0:refreshUI()
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_15_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0.costMatData = arg_16_0.viewParam.costMatData
	arg_16_0.targetMatData = arg_16_0.viewParam.targetMatData
	arg_16_0._exchangeFunc = arg_16_0.viewParam.exchangeFunc
	arg_16_0._exchangeFuncObj = arg_16_0.viewParam.exchangeFuncObj
	arg_16_0._getMaxTimeFunc = arg_16_0.viewParam.getMaxTimeFunc
	arg_16_0._getMaxTimeFuncObj = arg_16_0.viewParam.getMaxTimeFuncObj
	arg_16_0._getExchangeNumFunc = arg_16_0.viewParam.getExchangeNumFunc
	arg_16_0._getExchangeNumFuncObj = arg_16_0.viewParam.getExchangeNumFuncObj
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:onUpdateParam()

	local var_17_0, var_17_1 = ItemModel.instance:getItemConfigAndIcon(arg_17_0.costMatData.materilType, arg_17_0.costMatData.materilId, true)
	local var_17_2, var_17_3 = ItemModel.instance:getItemConfigAndIcon(arg_17_0.targetMatData.materilType, arg_17_0.targetMatData.materilId, true)

	arg_17_0._simageleftproduct:LoadImage(var_17_1)
	arg_17_0._simagerightproduct:LoadImage(var_17_3)

	local var_17_4 = arg_17_0.costMatData.materilType == MaterialEnum.MaterialType.Currency

	if var_17_4 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_17_0._simagecosticon, var_17_0.icon .. "_1", true)
	end

	gohelper.setActive(arg_17_0._gocost, var_17_4)

	arg_17_0.costItemCfg = var_17_0
	arg_17_0.targetItemCfg = var_17_2

	arg_17_0:_btnminOnClick()
end

function var_0_0.changeExchangeTimes(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = arg_18_0:getMaxExchangeTimes()

	arg_18_0.exchangeTimes = Mathf.Clamp(arg_18_1, var_0_3, var_18_1)

	if arg_18_2 then
		arg_18_0._inputvalue:SetText(tostring(arg_18_0.exchangeTimes))
	else
		arg_18_0._inputvalue:SetTextWithoutNotify(tostring(arg_18_0.exchangeTimes))
	end

	arg_18_0:refreshUI()
end

function var_0_0.getMaxExchangeTimes(arg_19_0)
	local var_19_0
	local var_19_1

	if arg_19_0._getMaxTimeFunc then
		var_19_0, var_19_1 = arg_19_0._getMaxTimeFunc(arg_19_0._getMaxTimeFuncObj)
	end

	local var_19_2 = Mathf.Max(var_0_3, var_19_0 or var_0_3)
	local var_19_3 = Mathf.Max(var_0_3, var_19_1 or var_19_2)

	return var_19_2, var_19_3
end

function var_0_0.refreshUI(arg_20_0)
	local var_20_0 = arg_20_0.exchangeTimes * (arg_20_0.costMatData.quantity or 0)
	local var_20_1 = arg_20_0.exchangeTimes * (arg_20_0.targetMatData.quantity or 0)

	if arg_20_0._getExchangeNumFunc then
		var_20_0, var_20_1 = arg_20_0._getExchangeNumFunc(arg_20_0._getExchangeNumFuncObj, arg_20_0.exchangeTimes)
	end

	local var_20_2 = var_20_0 <= ItemModel.instance:getItemQuantity(arg_20_0.costMatData.materilType, arg_20_0.costMatData.materilId)

	UIColorHelper.set(arg_20_0._inputText, var_20_2 and var_0_1 or var_0_2)

	local var_20_3 = ""

	if arg_20_0.costItemCfg then
		var_20_3 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), arg_20_0.costItemCfg.name, var_20_0)
	end

	arg_20_0._txtleftproductname.text = var_20_3
	arg_20_0._txtoriginalCost.text = var_20_0

	local var_20_4 = ""

	if arg_20_0.targetItemCfg then
		var_20_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), arg_20_0.targetItemCfg.name, var_20_1)
	end

	arg_20_0._txtrightproductname.text = var_20_4

	local var_20_5 = arg_20_0.exchangeTimes > 0

	gohelper.setActive(arg_20_0._btnbuy, var_20_5 and var_20_2)
	gohelper.setActive(arg_20_0._gobuylimit, not var_20_5 or not var_20_2)
end

function var_0_0.onClose(arg_21_0)
	arg_21_0._simageleftbg:UnLoadImage()
	arg_21_0._simagerightbg:UnLoadImage()
	arg_21_0._simageleftproduct:UnLoadImage()
	arg_21_0._simagerightproduct:UnLoadImage()
end

return var_0_0
