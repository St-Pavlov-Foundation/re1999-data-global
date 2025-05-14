module("modules.logic.store.view.RoomCritterStoreView", package.seeall)

local var_0_0 = class("RoomCritterStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tab")
	arg_1_0._gotab = gohelper.findChild(arg_1_0.viewGO, "#scroll_tab/Viewport/Content/#go_tab")
	arg_1_0._scrollgoods = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_goods")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_2_0._updateInfo, arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_2_0._updateInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_3_0._updateInfo, arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_3_0._updateInfo, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._updateInfo(arg_6_0)
	StoreCritterGoodsItemListModel.instance:setMOList(StoreEnum.StoreId.CritterStore)
end

function var_0_0.onOpen(arg_7_0)
	gohelper.setActive(arg_7_0._gotab, false)
	gohelper.setActive(arg_7_0._scrolltab.gameObject, false)
	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.CritterStore
	}, arg_7_0._updateInfo, arg_7_0)
end

function var_0_0._getTabItem(arg_8_0, arg_8_1)
	if not arg_8_0._tabItems then
		arg_8_0._tabItems = arg_8_0:getUserDataTb_()
	end

	local var_8_0 = arg_8_0._tabItems[arg_8_1]

	if not var_8_0 then
		var_8_0 = {}

		local var_8_1 = gohelper.cloneInPlace(arg_8_0._gotab)

		var_8_0.goSelect = gohelper.findChild(var_8_1, "bg/select")
		var_8_0.btn = gohelper.findChildButtonWithAudio(var_8_1, "bg/btn")

		var_8_0.btn:AddClickListener(arg_8_0._onClickTab, arg_8_0, arg_8_1)

		var_8_0.txt = gohelper.findChildText(var_8_1, "txt")
		var_8_0.go = var_8_1
	end

	arg_8_0._tabItems[arg_8_1] = var_8_0

	return var_8_0
end

function var_0_0._onClickTab(arg_9_0, arg_9_1)
	if arg_9_0._selectTabIndex == arg_9_1 then
		return
	end

	arg_9_0._selectTabIndex = arg_9_1

	arg_9_0:_refreshSelectTab()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._tabItems then
		for iter_11_0 = 1, #arg_11_0._tabItems do
			arg_11_0._tabItems[iter_11_0].btn:RemoveClickListener()
		end
	end
end

return var_0_0
