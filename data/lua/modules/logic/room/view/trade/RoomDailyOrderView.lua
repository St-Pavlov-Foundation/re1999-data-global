module("modules.logic.room.view.trade.RoomDailyOrderView", package.seeall)

local var_0_0 = class("RoomDailyOrderView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "tip")
	arg_1_0._txttip1 = gohelper.findChildText(arg_1_0.viewGO, "tip/#txt_tip1")
	arg_1_0._txttip2 = gohelper.findChildText(arg_1_0.viewGO, "tip/#txt_tip2")
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._gonotorder = gohelper.findChild(arg_1_0.viewGO, "#go_notorder")
	arg_1_0._gorole = gohelper.findChild(arg_1_0.viewGO, "#go_notorder/spine/#go_role")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_notorder/barrage/namebg/#txt_name")
	arg_1_0._scrollbarrage = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_notorder/barrage/#scroll_barrage")
	arg_1_0._txtbarrage = gohelper.findChildText(arg_1_0.viewGO, "#go_notorder/barrage/#scroll_barrage/Viewport/#txt_barrage")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_notorder/#simage_icon")
	arg_1_0._gonotorder2 = gohelper.findChild(arg_1_0.viewGO, "#go_notorder2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_notorder2/#simage_icon")
	arg_1_0._txtbarrage2 = gohelper.findChildText(arg_1_0.viewGO, "#go_notorder2/barrage/#scroll_barrage/Viewport/#txt_barrage")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "#go_notorder2/barrage/namebg/#txt_name")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_2_0.refrshCurrency, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_2_0.onRefresh, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, arg_2_0.finishOrder, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnRefreshDailyOrder, arg_2_0.refreshOrder, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnTracedDailyOrder, arg_2_0.refreshTraced, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnLockedDailyOrder, arg_2_0.refreshLocked, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0.refrshCurrency, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_3_0.onRefresh, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, arg_3_0.finishOrder, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnRefreshDailyOrder, arg_3_0.refreshOrder, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnTracedDailyOrder, arg_3_0.refreshTraced, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnLockedDailyOrder, arg_3_0.refreshLocked, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	local var_4_0 = ServerTime.ReplaceUTCStr(luaLang("p_roomdailyorderview_txt_notoder"))

	arg_4_0._tips1 = gohelper.findChildText(arg_4_0.viewGO, "#go_notorder/tipsbg/txt_tips")
	arg_4_0._tips2 = gohelper.findChildText(arg_4_0.viewGO, "#go_notorder2/tipsbg/txt_tips")
	arg_4_0._tips1.text = var_4_0
	arg_4_0._tips2.text = var_4_0
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:onRefresh()
end

function var_0_0.onRefresh(arg_7_0)
	arg_7_0:refreshOrderItem()
	arg_7_0:refreshFinishCount()
	arg_7_0:refreshRefreshCount()
end

function var_0_0._getOrderItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._orderItems[arg_8_1]

	if not var_8_0 then
		local var_8_1 = arg_8_0:getResInst(RoomDailyOrderItem.ResUrl, arg_8_0._goroot, string.format("roomdailyorderitem%s", arg_8_1))

		var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, RoomDailyOrderItem)
		var_8_0.viewContainer = arg_8_0.viewContainer
		arg_8_0._orderItems[arg_8_1] = var_8_0

		var_8_0:playOpenAnim(arg_8_1)
	end

	return var_8_0
end

function var_0_0.refreshFinishCount(arg_9_0)
	local var_9_0 = luaLang("room_tade_dailyorder_tip")
	local var_9_1, var_9_2 = RoomTradeModel.instance:getDailyOrderFinishCount()
	local var_9_3 = var_9_2 <= var_9_1
	local var_9_4 = var_9_3 and "#a63838" or "#EFEFEF"

	arg_9_0._txttip1.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_9_0, var_9_4, var_9_1, var_9_2)

	arg_9_0:refreshFinishBarrage(var_9_3)
end

function var_0_0.refreshRefreshCount(arg_10_0)
	local var_10_0 = luaLang("room_tade_dailyorder_active_refresh_tip")
	local var_10_1, var_10_2 = RoomTradeModel.instance:getRefreshCount()
	local var_10_3 = var_10_2 - var_10_1
	local var_10_4 = var_10_2 <= var_10_3 and "#a63838" or "#EFEFEF"

	arg_10_0._txttip2.text = GameUtil.getSubPlaceholderLuaLangThreeParam(var_10_0, var_10_4, var_10_3, var_10_2)

	gohelper.setActive(arg_10_0._txttip2, var_10_2 > 0)
end

function var_0_0.refreshFinishBarrage(arg_11_0, arg_11_1)
	if arg_11_1 then
		local var_11_0 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.DailyOrder)
		local var_11_1 = var_11_0.heroId
		local var_11_2 = var_11_0.icon
		local var_11_3
		local var_11_4

		if not string.nilorempty(var_11_2) then
			local var_11_5 = tonumber(var_11_2)

			var_11_3, var_11_4 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_11_5)
		end

		if var_11_1 and var_11_1 ~= 0 then
			local var_11_6 = HeroConfig.instance:getHeroCO(var_11_1).skinId

			arg_11_0.skinCo = SkinConfig.instance:getSkinCo(var_11_6)

			if not arg_11_0.smallSpine then
				arg_11_0.smallSpine = GuiSpine.Create(arg_11_0._gorole, false)
			end

			arg_11_0.smallSpine:stopVoice()
			arg_11_0.smallSpine:setResPath(ResUrl.getSpineUIPrefab(arg_11_0.skinCo.spine), arg_11_0._onSpineLoaded, arg_11_0, true)

			if not string.nilorempty(var_11_4) then
				arg_11_0._simageicon:LoadImage(var_11_4)
			end

			if var_11_3 then
				arg_11_0._txtname.text = var_11_3.name
			end

			arg_11_0._txtbarrage.text = var_11_0.desc

			gohelper.setActive(arg_11_0._gonotorder, true)
			gohelper.setActive(arg_11_0._gonotorder2, false)
		else
			if not string.nilorempty(var_11_4) then
				arg_11_0._simageicon2:LoadImage(var_11_4)
			end

			if var_11_3 then
				arg_11_0._txtname2.text = var_11_3.name
			end

			arg_11_0._txtbarrage2.text = var_11_0.desc

			gohelper.setActive(arg_11_0._gonotorder, false)
			gohelper.setActive(arg_11_0._gonotorder2, true)
		end

		arg_11_0._animator:Play(RoomTradeEnum.TradeAnim.DailyOrderOpen, 0, 0)
	else
		gohelper.setActive(arg_11_0._gonotorder, false)
		gohelper.setActive(arg_11_0._gonotorder2, false)
	end

	gohelper.setActive(arg_11_0._goroot, not arg_11_1)
	gohelper.setActive(arg_11_0._gotip, not arg_11_1)
end

function var_0_0._onSpineLoaded(arg_12_0)
	local var_12_0 = SkinConfig.instance:getSkinOffset(arg_12_0.skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_12_0._gorole.transform, tonumber(var_12_0[1]), tonumber(var_12_0[2]))
	transformhelper.setLocalScale(arg_12_0._gorole.transform, tonumber(var_12_0[3]), tonumber(var_12_0[3]), tonumber(var_12_0[3]))
end

function var_0_0.refreshOrderItem(arg_13_0)
	local var_13_0 = RoomTradeModel.instance:getDailyOrders()

	if not arg_13_0._orderItems then
		arg_13_0._orderItems = arg_13_0:getUserDataTb_()
	end

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			arg_13_0:_getOrderItem(iter_13_0):onUpdateMo(iter_13_1)
		end

		for iter_13_2 = #var_13_0 + 1, #arg_13_0._orderItems do
			gohelper.setActive(arg_13_0._orderItems[iter_13_2].viewGO, false)
		end
	end
end

function var_0_0.finishOrder(arg_14_0, arg_14_1)
	if arg_14_1 ~= RoomTradeEnum.Mode.DailyOrder then
		return
	end

	arg_14_0:onRefresh()
end

function var_0_0.refreshOrder(arg_15_0)
	arg_15_0:onRefresh()
end

function var_0_0.refrshCurrency(arg_16_0)
	local var_16_0 = RoomTradeModel.instance:getDailyOrders()

	if var_16_0 then
		for iter_16_0 = 1, #var_16_0 do
			arg_16_0:_getOrderItem(iter_16_0):onRefresh()
		end
	end
end

function var_0_0.refreshTraced(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = RoomTradeModel.instance:getDailyOrderById(arg_17_1)

	arg_17_0:_getOrderItem(var_17_1):refreshTraced()
end

function var_0_0.refreshLocked(arg_18_0, arg_18_1)
	local var_18_0, var_18_1 = RoomTradeModel.instance:getDailyOrderById(arg_18_1)

	arg_18_0:_getOrderItem(var_18_1):refreshLocked()
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0.smallSpine then
		arg_20_0.smallSpine:stopVoice()

		arg_20_0.smallSpine = nil
	end
end

return var_0_0
