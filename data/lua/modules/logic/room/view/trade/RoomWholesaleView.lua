module("modules.logic.room.view.trade.RoomWholesaleView", package.seeall)

slot0 = class("RoomWholesaleView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#txt_tip")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "tipsbg2/#txt_num")
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_right")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, slot0.finishOrder, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, slot0.finishOrder, slot0)
end

function slot0._btnleftOnClick(slot0)
	if slot0._selectPageIndex <= 0 or slot0._isPlaySwitchAnim then
		return
	end

	slot0._selectPageIndex = slot0._selectPageIndex - 1

	slot0:_cutPage()
end

function slot0._btnrightOnClick(slot0)
	if RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() <= slot0._selectPageIndex or slot0._isPlaySwitchAnim then
		return
	end

	slot0._selectPageIndex = slot0._selectPageIndex + 1

	slot0:_cutPage()
end

function slot0._cutPage(slot0)
	slot0._isPlaySwitchAnim = true

	slot0.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	TaskDispatcher.cancelTask(slot0.refreshOrderPage, slot0)
	TaskDispatcher.runDelay(slot0.refreshOrderPage, slot0, 0.16)
end

function slot0._editableInitView(slot0)
	slot0._txttip.text = ServerTime.ReplaceUTCStr(luaLang("p_roomwholesaleview_txt_tip2"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._selectPageIndex = 0

	slot0:onRefresh()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshOrderPage, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onRefresh(slot0)
	slot0:refreshOrderPage()

	slot0._txtnum.text = RoomTradeModel.instance:getWeeklyWholesaleRevenue()
end

function slot0._getOrderItem(slot0, slot1)
	if not slot0._orderItems[slot1] then
		slot0._orderItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomWholesaleItem.ResUrl, slot0._goroot), RoomWholesaleItem)
	end

	return slot2
end

function slot0.refreshOrderPage(slot0)
	slot0._isPlaySwitchAnim = nil
	slot1 = RoomTradeModel.instance:getWholesaleGoodsByPageIndex(slot0._selectPageIndex)

	if not slot0._orderItems then
		slot0._orderItems = slot0:getUserDataTb_()
	end

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:_getOrderItem(slot5):onUpdateMo(slot6)
		end

		for slot5 = 1, #slot0._orderItems do
			gohelper.setActive(slot0._orderItems[slot5].viewGO, slot5 <= #slot1)
		end
	end

	gohelper.setActive(slot0._btnleft.gameObject, slot0._selectPageIndex > 0)
	gohelper.setActive(slot0._btnright.gameObject, slot0._selectPageIndex < RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() - 1)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnCutOrderPage, slot0._selectPageIndex + 1)
end

function slot0.finishOrder(slot0, slot1)
	if slot1 ~= RoomTradeEnum.Mode.Wholesale then
		return
	end

	slot0:onRefresh()
end

return slot0
