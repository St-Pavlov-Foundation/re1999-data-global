module("modules.logic.versionactivity2_3.enter.view.subview.VersionActivity2_3Act174EnterView", package.seeall)

local var_0_0 = class("VersionActivity2_3Act174EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
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
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function var_0_0._btnEnterOnClick(arg_5_0)
	Activity174Controller.instance:openMainView({
		actId = arg_5_0.actId
	})
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.animComp = VersionActivitySubAnimatorComp.get(arg_6_0.viewGO, arg_6_0)
	arg_6_0.actId = VersionActivity2_3Enum.ActivityId.Act174

	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId)

	arg_6_0._txtdesc.text = var_6_0.actDesc
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.animComp:playOpenAnim()
	arg_7_0:refreshUI()
	arg_7_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_7_0.refreshCurrency, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_8_0.refreshCurrency, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshLeftTime, arg_9_0)
	arg_9_0.animComp:destroy()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshLeftTime()
	arg_10_0:refreshCurrency()
	TaskDispatcher.runRepeat(arg_10_0.refreshLeftTime, arg_10_0, TimeUtil.OneSecond)
end

function var_0_0.refreshLeftTime(arg_11_0)
	arg_11_0._txttime.text = ActivityHelper.getActivityRemainTimeStr(arg_11_0.actId)
end

function var_0_0.refreshCurrency(arg_12_0)
	local var_12_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu)

	arg_12_0._txtnum.text = var_12_0.quantity
end

return var_0_0
