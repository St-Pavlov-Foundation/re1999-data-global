module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteBargainItem", package.seeall)

slot0 = class("ActivityQuoteBargainItem", UserDataDispose)

function slot0.ctor(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0._gotarget = gohelper.clone(slot2, gohelper.findChild(slot0.viewGO, "#go_target"))

	recthelper.setAnchor(slot0._gotarget.transform, 0, 0)

	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_info")
	slot0._content = gohelper.findChild(slot0.viewGO, "#scroll_info/Viewport/Content")
	slot0._goquoteitem = gohelper.findChild(slot0.viewGO, "#scroll_info/Viewport/Content/#go_quoteitem")

	slot0:initDailySelected()
	slot0:addEvents()
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refresh(slot0, slot1)
	slot0.actId = slot1

	if slot0:noSelectOrder() then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot2 = Activity117Model.instance:getOrderDataById(slot0.actId, slot0:getSelectOrderId())

	if not slot0.quoteItem then
		slot0.quoteItem = ActivityQuoteItem.New(slot0._goquoteitem)
	end

	slot0.quoteItem:setData(slot2)
	slot0._selectItem:setData(slot2)
end

function slot0.initDailySelected(slot0)
	slot0._selectItem = ActivityQuoteDemandItem.New(slot0._gotarget, true)
end

function slot0.getSelectOrderId(slot0)
	return Activity117Model.instance:getSelectOrder(slot0.actId)
end

function slot0.noSelectOrder(slot0)
	return not slot0:getSelectOrderId()
end

function slot0.onDeal(slot0)
	if slot0:noSelectOrder() then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot1 = Activity117Model.instance:getOrderDataById(slot0.actId, slot0:getSelectOrderId())

	if not slot0.quoteItem then
		slot0.quoteItem = ActivityQuoteItem.New(slot0._goquoteitem)
	end

	slot0.quoteItem:setData(slot1)
	slot0._selectItem:setData(slot1)
end

function slot0.onNegotiate(slot0)
	if slot0:noSelectOrder() then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	if slot0.quoteItem then
		slot0.quoteItem:onNegotiate(Activity117Model.instance:getOrderDataById(slot0.actId, slot0:getSelectOrderId()))
	end
end

function slot0.destory(slot0)
	if slot0.quoteItem then
		slot0.quoteItem:destory()

		slot0.quoteItem = nil
	end

	if slot0._selectItem then
		slot0._selectItem:destory()

		slot0._selectItem = nil
	end

	slot0:removeEvents()
	slot0:__onDispose()
end

return slot0
