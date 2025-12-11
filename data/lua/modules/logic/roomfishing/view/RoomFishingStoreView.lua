module("modules.logic.roomfishing.view.RoomFishingStoreView", package.seeall)

local var_0_0 = class("RoomFishingStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_content")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_content/#go_storegoodsitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0._onStoreInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_2_0._onStoreInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0._onStoreInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_3_0._onStoreInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._onDailyRefresh(arg_4_0)
	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.RoomFishingStore
	})
end

function var_0_0._onStoreInfoUpdate(arg_5_0)
	arg_5_0:setGoodsItems()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:setGoodsItems()
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_jihuan)
end

local function var_0_1(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:isSoldOut()
	local var_9_1 = arg_9_1:isSoldOut()
	local var_9_2 = arg_9_0:alreadyHas()
	local var_9_3 = arg_9_1:alreadyHas()

	if var_9_2 and not var_9_3 then
		return false
	elseif var_9_3 and not var_9_2 then
		return true
	end

	if var_9_0 and not var_9_1 then
		return false
	elseif var_9_1 and not var_9_0 then
		return true
	end

	local var_9_4 = StoreConfig.instance:getGoodsConfig(arg_9_0.goodsId)
	local var_9_5 = StoreConfig.instance:getGoodsConfig(arg_9_1.goodsId)

	if var_9_4.order ~= var_9_5.order then
		return var_9_4.order < var_9_5.order
	end

	return var_9_4.id < var_9_5.id
end

function var_0_0.setGoodsItems(arg_10_0)
	local var_10_0 = FishingStoreModel.instance:getStoreGroupMO()
	local var_10_1 = var_10_0 and var_10_0:getGoodsList() or {}

	table.sort(var_10_1, var_0_1)
	gohelper.CreateObjList(arg_10_0, arg_10_0._onGoodsItemShow, var_10_1, arg_10_0._gocontent, arg_10_0._gostoregoodsitem, RoomFishingStoreItem)
end

function var_0_0._onGoodsItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_1:onUpdateMO(arg_11_2)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
