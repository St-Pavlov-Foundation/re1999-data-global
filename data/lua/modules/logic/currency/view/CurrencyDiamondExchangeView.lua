module("modules.logic.currency.view.CurrencyDiamondExchangeView", package.seeall)

local var_0_0 = class("CurrencyDiamondExchangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_rightbg")
	arg_1_0._txtleftproductname = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_leftproductname")
	arg_1_0._simageleftproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/#simage_leftproduct")
	arg_1_0._txtrightproductname = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_rightproductname")
	arg_1_0._simagerightproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#simage_rightproduct")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "#go_buy")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_buy/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_buy")
	arg_1_0._gobuylimit = gohelper.findChild(arg_1_0.viewGO, "#go_buy/#go_buylimit")
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

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

var_0_0.ClickStep = 1
var_0_0.MinAmount = 0

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._currenctAmount = var_0_0.MinAmount

	local var_5_0 = MaterialEnum.MaterialType.Currency
	local var_5_1 = CurrencyEnum.CurrencyType.Diamond
	local var_5_2, var_5_3 = ItemModel.instance:getItemConfigAndIcon(var_5_0, var_5_1, true)

	arg_5_0._txtleftproductname.text = string.format("%s %s1", var_5_2.name, luaLang("multiple"))

	local var_5_4 = CurrencyEnum.CurrencyType.FreeDiamondCoupon
	local var_5_5, var_5_6 = ItemModel.instance:getItemConfigAndIcon(var_5_0, var_5_4, true)

	arg_5_0._txtrightproductname.text = string.format("%s %s1", var_5_5.name, luaLang("multiple"))

	arg_5_0._inputvalue:AddOnEndEdit(arg_5_0._onInputNameEndEdit, arg_5_0)

	arg_5_0._inputText = arg_5_0._inputvalue.inputField.textComponent
	arg_5_0._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)

	arg_5_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_5_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_5_0._simageleftproduct:LoadImage(ResUrl.getCurrencyItemIcon("201"))
	arg_5_0._simagerightproduct:LoadImage(ResUrl.getCurrencyItemIcon("202"))
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_5_0._simagecosticon, "201_1")
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0._inputvalue:RemoveOnEndEdit()
	arg_6_0._simageleftbg:UnLoadImage()
	arg_6_0._simagerightbg:UnLoadImage()
	arg_6_0._simageleftproduct:UnLoadImage()
	arg_6_0._simagerightproduct:UnLoadImage()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:onOpen()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._currenctAmount = 1

	arg_8_0:refreshAmount()
	arg_8_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.refreshAmount, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_9_0.refreshAmount, arg_9_0)
end

function var_0_0.refreshAmount(arg_10_0)
	arg_10_0:checkCurrenctAmount()

	local var_10_0 = tostring(arg_10_0._currenctAmount)
	local var_10_1 = arg_10_0:getOwnAmount() >= arg_10_0._currenctAmount
	local var_10_2 = arg_10_0._colorDefault

	if not var_10_1 then
		var_10_2 = Color.red
	end

	arg_10_0._inputText.color = var_10_2

	arg_10_0._inputvalue:SetText(var_10_0)

	arg_10_0._txtoriginalCost.text = var_10_0

	gohelper.setActive(arg_10_0._btnbuy.gameObject, arg_10_0._currenctAmount > 0)
	gohelper.setActive(arg_10_0._gobuylimit, arg_10_0._currenctAmount <= 0)
end

function var_0_0._onInputNameEndEdit(arg_11_0)
	arg_11_0._currenctAmount = tonumber(arg_11_0._inputvalue:GetText())

	arg_11_0:refreshAmount()
end

function var_0_0._btnminOnClick(arg_12_0)
	if arg_12_0:getOwnAmount() <= 0 then
		arg_12_0._currenctAmount = 0
	else
		arg_12_0._currenctAmount = 1
	end

	arg_12_0:refreshAmount()
end

function var_0_0._btnmaxOnClick(arg_13_0)
	arg_13_0._currenctAmount = arg_13_0:getOwnAmount()

	arg_13_0:refreshAmount()
end

function var_0_0._btnsubOnClick(arg_14_0)
	if arg_14_0._currenctAmount ~= nil then
		arg_14_0._currenctAmount = arg_14_0._currenctAmount - var_0_0.ClickStep

		arg_14_0:refreshAmount()
	end
end

function var_0_0._btnaddOnClick(arg_15_0)
	if arg_15_0._currenctAmount ~= nil then
		arg_15_0._currenctAmount = arg_15_0._currenctAmount + var_0_0.ClickStep

		arg_15_0:refreshAmount()
	end
end

function var_0_0._btnbuyOnClick(arg_16_0)
	if arg_16_0._currenctAmount ~= nil and arg_16_0._currenctAmount > 0 then
		if arg_16_0:getOwnAmount() >= arg_16_0._currenctAmount then
			CurrencyRpc.instance:sendExchangeDiamondRequest(arg_16_0._currenctAmount, CurrencyEnum.PayDiamondExchangeSource.HUD, arg_16_0.closeThis, arg_16_0)
		else
			local var_16_0 = MaterialEnum.MaterialType.Currency
			local var_16_1 = CurrencyEnum.CurrencyType.Diamond
			local var_16_2, var_16_3 = ItemModel.instance:getItemConfigAndIcon(var_16_0, var_16_1, true)

			GameFacade.showToast(ToastEnum.DiamondBuy, var_16_2.name)
		end
	end
end

function var_0_0.checkCurrenctAmount(arg_17_0)
	local var_17_0 = arg_17_0:getOwnAmount()

	if arg_17_0._currenctAmount == nil then
		arg_17_0._currenctAmount = 1
	end

	if arg_17_0._currenctAmount < var_0_0.MinAmount then
		arg_17_0._currenctAmount = var_0_0.MinAmount
	end
end

function var_0_0.getOwnAmount(arg_18_0)
	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Diamond)
end

function var_0_0.onClickModalMask(arg_19_0)
	arg_19_0:closeThis()
end

return var_0_0
