module("modules.logic.room.view.trade.RoomDailyOrderView", package.seeall)

slot0 = class("RoomDailyOrderView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotip = gohelper.findChild(slot0.viewGO, "tip")
	slot0._txttip1 = gohelper.findChildText(slot0.viewGO, "tip/#txt_tip1")
	slot0._txttip2 = gohelper.findChildText(slot0.viewGO, "tip/#txt_tip2")
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._gonotorder = gohelper.findChild(slot0.viewGO, "#go_notorder")
	slot0._gorole = gohelper.findChild(slot0.viewGO, "#go_notorder/spine/#go_role")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_notorder/barrage/namebg/#txt_name")
	slot0._scrollbarrage = gohelper.findChildScrollRect(slot0.viewGO, "#go_notorder/barrage/#scroll_barrage")
	slot0._txtbarrage = gohelper.findChildText(slot0.viewGO, "#go_notorder/barrage/#scroll_barrage/Viewport/#txt_barrage")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_notorder/#simage_icon")
	slot0._gonotorder2 = gohelper.findChild(slot0.viewGO, "#go_notorder2")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_notorder2/#simage_icon")
	slot0._txtbarrage2 = gohelper.findChildText(slot0.viewGO, "#go_notorder2/barrage/#scroll_barrage/Viewport/#txt_barrage")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "#go_notorder2/barrage/namebg/#txt_name")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0.refrshCurrency, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, slot0.finishOrder, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnRefreshDailyOrder, slot0.refreshOrder, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnTracedDailyOrder, slot0.refreshTraced, slot0)
end

function slot0.removeEvents(slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0.refrshCurrency, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, slot0.finishOrder, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnRefreshDailyOrder, slot0.refreshOrder, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnTracedDailyOrder, slot0.refreshTraced, slot0)
end

function slot0._editableInitView(slot0)
	slot1 = ServerTime.ReplaceUTCStr(luaLang("p_roomdailyorderview_txt_notoder"))
	slot0._tips1 = gohelper.findChildText(slot0.viewGO, "#go_notorder/tipsbg/txt_tips")
	slot0._tips2 = gohelper.findChildText(slot0.viewGO, "#go_notorder2/tipsbg/txt_tips")
	slot0._tips1.text = slot1
	slot0._tips2.text = slot1
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:onRefresh()
end

function slot0.onRefresh(slot0)
	slot0:refreshOrderItem()
	slot0:refreshFinishCount()
	slot0:refreshRefreshCount()
end

function slot0._getOrderItem(slot0, slot1)
	if not slot0._orderItems[slot1] then
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(RoomDailyOrderItem.ResUrl, slot0._goroot, string.format("roomdailyorderitem%s", slot1)), RoomDailyOrderItem)
		slot2.viewContainer = slot0.viewContainer
		slot0._orderItems[slot1] = slot2

		slot2:playOpenAnim(slot1)
	end

	return slot2
end

function slot0.refreshFinishCount(slot0)
	slot2, slot3 = RoomTradeModel.instance:getDailyOrderFinishCount()
	slot4 = slot3 <= slot2
	slot0._txttip1.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("room_tade_dailyorder_tip"), slot4 and "#a63838" or "#EFEFEF", slot2, slot3)

	slot0:refreshFinishBarrage(slot4)
end

function slot0.refreshRefreshCount(slot0)
	slot2, slot3 = RoomTradeModel.instance:getRefreshCount()
	slot0._txttip2.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("room_tade_dailyorder_active_refresh_tip"), slot3 <= slot3 - slot2 and "#a63838" or "#EFEFEF", slot2, slot3)
end

function slot0.refreshFinishBarrage(slot0, slot1)
	if slot1 then
		slot2 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.DailyOrder)
		slot3 = slot2.heroId
		slot5, slot6 = nil

		if not string.nilorempty(slot2.icon) then
			slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, tonumber(slot4))
		end

		if slot3 and slot3 ~= 0 then
			slot0.skinCo = SkinConfig.instance:getSkinCo(HeroConfig.instance:getHeroCO(slot3).skinId)

			if not slot0.smallSpine then
				slot0.smallSpine = GuiSpine.Create(slot0._gorole, false)
			end

			slot0.smallSpine:stopVoice()
			slot0.smallSpine:setResPath(ResUrl.getSpineUIPrefab(slot0.skinCo.spine), slot0._onSpineLoaded, slot0, true)

			if not string.nilorempty(slot6) then
				slot0._simageicon:LoadImage(slot6)
			end

			if slot5 then
				slot0._txtname.text = slot5.name
			end

			slot0._txtbarrage.text = slot2.desc

			gohelper.setActive(slot0._gonotorder, true)
			gohelper.setActive(slot0._gonotorder2, false)
		else
			if not string.nilorempty(slot6) then
				slot0._simageicon2:LoadImage(slot6)
			end

			if slot5 then
				slot0._txtname2.text = slot5.name
			end

			slot0._txtbarrage2.text = slot2.desc

			gohelper.setActive(slot0._gonotorder, false)
			gohelper.setActive(slot0._gonotorder2, true)
		end

		slot0._animator:Play(RoomTradeEnum.TradeAnim.DailyOrderOpen, 0, 0)
	else
		gohelper.setActive(slot0._gonotorder, false)
		gohelper.setActive(slot0._gonotorder2, false)
	end

	gohelper.setActive(slot0._goroot, not slot1)
	gohelper.setActive(slot0._gotip, not slot1)
end

function slot0._onSpineLoaded(slot0)
	slot1 = SkinConfig.instance:getSkinOffset(slot0.skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gorole.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gorole.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
end

function slot0.refreshOrderItem(slot0)
	slot1 = RoomTradeModel.instance:getDailyOrders()

	if not slot0._orderItems then
		slot0._orderItems = slot0:getUserDataTb_()
	end

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot0:_getOrderItem(slot5):onUpdateMo(slot6)
		end

		for slot5 = #slot1 + 1, #slot0._orderItems do
			gohelper.setActive(slot0._orderItems[slot5].viewGO, false)
		end
	end
end

function slot0.finishOrder(slot0, slot1)
	if slot1 ~= RoomTradeEnum.Mode.DailyOrder then
		return
	end

	slot0:onRefresh()
end

function slot0.refreshOrder(slot0)
	slot0:onRefresh()
end

function slot0.refrshCurrency(slot0)
	if RoomTradeModel.instance:getDailyOrders() then
		for slot5 = 1, #slot1 do
			slot0:_getOrderItem(slot5):onRefresh()
		end
	end
end

function slot0.refreshTraced(slot0, slot1)
	slot2, slot3 = RoomTradeModel.instance:getDailyOrderById(slot1)

	slot0:_getOrderItem(slot3):refreshTraced()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.smallSpine then
		slot0.smallSpine:stopVoice()

		slot0.smallSpine = nil
	end
end

return slot0
