module("modules.logic.room.view.trade.RoomWholesaleView", package.seeall)

local var_0_0 = class("RoomWholesaleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#txt_tip")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "tipsbg2/#txt_num")
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_right")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_2_0.onRefresh, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, arg_2_0.finishOrder, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_3_0.onRefresh, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, arg_3_0.finishOrder, arg_3_0)
end

function var_0_0._btnleftOnClick(arg_4_0)
	if arg_4_0._selectPageIndex <= 0 or arg_4_0._isPlaySwitchAnim then
		return
	end

	arg_4_0._selectPageIndex = arg_4_0._selectPageIndex - 1

	arg_4_0:_cutPage()
end

function var_0_0._btnrightOnClick(arg_5_0)
	if arg_5_0._selectPageIndex >= RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() or arg_5_0._isPlaySwitchAnim then
		return
	end

	arg_5_0._selectPageIndex = arg_5_0._selectPageIndex + 1

	arg_5_0:_cutPage()
end

function var_0_0._cutPage(arg_6_0)
	arg_6_0._isPlaySwitchAnim = true

	arg_6_0.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	TaskDispatcher.cancelTask(arg_6_0.refreshOrderPage, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.refreshOrderPage, arg_6_0, 0.16)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txttip.text = ServerTime.ReplaceUTCStr(luaLang("p_roomwholesaleview_txt_tip2"))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._selectPageIndex = 0

	arg_9_0:onRefresh()
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshOrderPage, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onRefresh(arg_12_0)
	arg_12_0:refreshOrderPage()

	arg_12_0._txtnum.text = RoomTradeModel.instance:getWeeklyWholesaleRevenue()
end

function var_0_0._getOrderItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._orderItems[arg_13_1]

	if not var_13_0 then
		local var_13_1 = arg_13_0:getResInst(RoomWholesaleItem.ResUrl, arg_13_0._goroot)

		var_13_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, RoomWholesaleItem)
		arg_13_0._orderItems[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.refreshOrderPage(arg_14_0)
	arg_14_0._isPlaySwitchAnim = nil

	local var_14_0 = RoomTradeModel.instance:getWholesaleGoodsByPageIndex(arg_14_0._selectPageIndex)

	if not arg_14_0._orderItems then
		arg_14_0._orderItems = arg_14_0:getUserDataTb_()
	end

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			arg_14_0:_getOrderItem(iter_14_0):onUpdateMo(iter_14_1)
		end

		for iter_14_2 = 1, #arg_14_0._orderItems do
			gohelper.setActive(arg_14_0._orderItems[iter_14_2].viewGO, iter_14_2 <= #var_14_0)
		end
	end

	local var_14_1 = arg_14_0._selectPageIndex > 0
	local var_14_2 = arg_14_0._selectPageIndex < RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() - 1

	gohelper.setActive(arg_14_0._btnleft.gameObject, var_14_1)
	gohelper.setActive(arg_14_0._btnright.gameObject, var_14_2)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnCutOrderPage, arg_14_0._selectPageIndex + 1)
end

function var_0_0.finishOrder(arg_15_0, arg_15_1)
	if arg_15_1 ~= RoomTradeEnum.Mode.Wholesale then
		return
	end

	arg_15_0:onRefresh()
end

return var_0_0
