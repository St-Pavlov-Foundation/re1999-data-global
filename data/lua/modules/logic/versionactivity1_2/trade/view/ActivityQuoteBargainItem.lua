module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteBargainItem", package.seeall)

local var_0_0 = class("ActivityQuoteBargainItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_target")

	arg_1_0._gotarget = gohelper.clone(arg_1_2, var_1_0)

	recthelper.setAnchor(arg_1_0._gotarget.transform, 0, 0)

	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_info")
	arg_1_0._content = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content")
	arg_1_0._goquoteitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#go_quoteitem")

	arg_1_0:initDailySelected()
	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refresh(arg_4_0, arg_4_1)
	arg_4_0.actId = arg_4_1

	if arg_4_0:noSelectOrder() then
		gohelper.setActive(arg_4_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_4_0.viewGO, true)

	local var_4_0 = Activity117Model.instance:getOrderDataById(arg_4_0.actId, arg_4_0:getSelectOrderId())

	if not arg_4_0.quoteItem then
		arg_4_0.quoteItem = ActivityQuoteItem.New(arg_4_0._goquoteitem)
	end

	arg_4_0.quoteItem:setData(var_4_0)
	arg_4_0._selectItem:setData(var_4_0)
end

function var_0_0.initDailySelected(arg_5_0)
	arg_5_0._selectItem = ActivityQuoteDemandItem.New(arg_5_0._gotarget, true)
end

function var_0_0.getSelectOrderId(arg_6_0)
	return Activity117Model.instance:getSelectOrder(arg_6_0.actId)
end

function var_0_0.noSelectOrder(arg_7_0)
	return not arg_7_0:getSelectOrderId()
end

function var_0_0.onDeal(arg_8_0)
	if arg_8_0:noSelectOrder() then
		gohelper.setActive(arg_8_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_8_0.viewGO, true)

	local var_8_0 = Activity117Model.instance:getOrderDataById(arg_8_0.actId, arg_8_0:getSelectOrderId())

	if not arg_8_0.quoteItem then
		arg_8_0.quoteItem = ActivityQuoteItem.New(arg_8_0._goquoteitem)
	end

	arg_8_0.quoteItem:setData(var_8_0)
	arg_8_0._selectItem:setData(var_8_0)
end

function var_0_0.onNegotiate(arg_9_0)
	if arg_9_0:noSelectOrder() then
		gohelper.setActive(arg_9_0.viewGO, false)

		return
	end

	local var_9_0 = Activity117Model.instance:getOrderDataById(arg_9_0.actId, arg_9_0:getSelectOrderId())

	if arg_9_0.quoteItem then
		arg_9_0.quoteItem:onNegotiate(var_9_0)
	end
end

function var_0_0.destory(arg_10_0)
	if arg_10_0.quoteItem then
		arg_10_0.quoteItem:destory()

		arg_10_0.quoteItem = nil
	end

	if arg_10_0._selectItem then
		arg_10_0._selectItem:destory()

		arg_10_0._selectItem = nil
	end

	arg_10_0:removeEvents()
	arg_10_0:__onDispose()
end

return var_0_0
