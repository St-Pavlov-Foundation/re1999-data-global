module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainQuoteView", package.seeall)

slot0 = class("ActivityTradeBargainQuoteView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotrade = gohelper.findChild(slot0.viewGO, "#go_trade")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.tradeItem = ActivityQuoteTradeItem.New(slot0._gotrade)
end

function slot0.onDestroyView(slot0)
	if slot0.tradeItem then
		slot0.tradeItem:destory()

		slot0.tradeItem = nil
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.RefreshQuoteView, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveNegotiate, slot0.onNegotiate, slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.RefreshQuoteView, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveDeal, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveNegotiate, slot0.onNegotiate, slot0)
end

function slot0._refreshUI(slot0)
	slot0.tradeItem:refresh(slot0.viewContainer:getActId())
end

function slot0.refreshUI(slot0, slot1)
	if slot1 ~= slot0.viewContainer:getActId() then
		return
	end

	slot0:_refreshUI()
end

function slot0.onNegotiate(slot0, slot1)
	if slot1 ~= slot0.viewContainer:getActId() then
		return
	end

	slot0.tradeItem:onNegotiate()
end

return slot0
