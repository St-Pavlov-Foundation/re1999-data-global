module("modules.logic.sdk.view.SDKSandboxPayView", package.seeall)

local var_0_0 = class("SDKSandboxPayView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtgoodsName = gohelper.findChildText(arg_1_0.viewGO, "goodsName/#txt_goodsName")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "cost/#txt_cost")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buy")
	arg_1_0._btnsdk = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_sdk")
	arg_1_0._txtbalance = gohelper.findChildText(arg_1_0.viewGO, "balance/#txt_balance")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnsdk:AddClickListener(arg_2_0._btnsdkOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnsdk:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_4_0)
	ChargeRpc.instance:sendSandboxChargeRequset(arg_4_0.payInfo.gameOrderId)
	arg_4_0:closeThis()
end

function var_0_0._btnsdkOnClick(arg_5_0)
	local var_5_0 = StatModel.instance:getPayInfo()

	SDKMgr.instance:payGoods(var_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.payInfo = arg_9_0.viewParam.payInfo

	local var_9_0 = StoreConfig.instance:getChargeGoodsConfig(arg_9_0.payInfo.goodsId)

	arg_9_0._txtcost.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(arg_9_0.payInfo.amount / 100))
	arg_9_0._txtgoodsName.text = arg_9_0.payInfo.goodsName
	arg_9_0._txtbalance.text = string.format("%s<indent=33>%s", StoreModel.instance:getCostStr(PayModel.instance:getSandboxBalance() / 100))
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
