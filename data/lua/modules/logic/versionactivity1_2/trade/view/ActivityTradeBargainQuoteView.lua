module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainQuoteView", package.seeall)

local var_0_0 = class("ActivityTradeBargainQuoteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotrade = gohelper.findChild(arg_1_0.viewGO, "#go_trade")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.tradeItem = ActivityQuoteTradeItem.New(arg_4_0._gotrade)
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0.tradeItem then
		arg_5_0.tradeItem:destory()

		arg_5_0.tradeItem = nil
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.RefreshQuoteView, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveNegotiate, arg_6_0.onNegotiate, arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.RefreshQuoteView, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveNegotiate, arg_7_0.onNegotiate, arg_7_0)
end

function var_0_0._refreshUI(arg_8_0)
	local var_8_0 = arg_8_0.viewContainer:getActId()

	arg_8_0.tradeItem:refresh(var_8_0)
end

function var_0_0.refreshUI(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.viewContainer:getActId() then
		return
	end

	arg_9_0:_refreshUI()
end

function var_0_0.onNegotiate(arg_10_0, arg_10_1)
	if arg_10_1 ~= arg_10_0.viewContainer:getActId() then
		return
	end

	arg_10_0.tradeItem:onNegotiate()
end

return var_0_0
