module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_Act191EnterView", package.seeall)

local var_0_0 = class("V3a1_Act191EnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnShop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Shop")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#btn_Shop/#txt_num")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Enter")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnShop:AddClickListener(arg_2_0._btnShopOnClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnShop:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
end

function var_0_0._btnShopOnClick(arg_4_0)
	Activity191Controller.instance:openStoreView(VersionActivity3_1Enum.ActivityId.DouQuQu3Store)
end

function var_0_0._btnEnterOnClick(arg_5_0)
	Activity191Controller.instance:enterActivity(arg_5_0.actId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = VersionActivity3_1Enum.ActivityId.DouQuQu3

	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId)

	arg_6_0._txtdesc.text = var_6_0.actDesc
end

function var_0_0.onOpen(arg_7_0)
	var_0_0.super.onOpen(arg_7_0)
	arg_7_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_7_0.refreshCurrency, arg_7_0)
	arg_7_0:refreshCurrency()
end

function var_0_0.everySecondCall(arg_8_0)
	arg_8_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_8_0.actId)
end

function var_0_0.refreshCurrency(arg_9_0)
	local var_9_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a1DouQuQu)

	arg_9_0._txtnum.text = var_9_0.quantity
end

return var_0_0
