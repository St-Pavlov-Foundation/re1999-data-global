module("modules.logic.store.view.ClothesStoreView", package.seeall)

local var_0_0 = class("ClothesStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._scrollprop.gameObject)
	arg_1_0._godeduction = gohelper.findChild(arg_1_0.viewGO, "#go_deduction")
	arg_1_0._txtdeduction = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_deduction/#txt_deadTime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_2_0._isSkinEmpty, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._payFinished, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._scrollprop:AddOnValueChanged(arg_2_0._onDragging, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_3_0._isSkinEmpty, arg_3_0)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._payFinished, arg_3_0)
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._scrollprop:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gostorecategoryitem, false)

	arg_4_0._categoryItemContainer = {}

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))
	gohelper.setActive(arg_4_0._goempty, false)
end

function var_0_0._isSkinEmpty(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goempty, arg_5_1)
end

function var_0_0._payFinished(arg_6_0)
	if ViewMgr.instance:isOpen(ViewName.StoreSkinPreviewView) then
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end

	arg_6_0:_refreshGoods(true)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListBegin)
end

function var_0_0._onDragging(arg_8_0)
	StoreController.instance:dispatchEvent(StoreEvent.DraggingSkinList)
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListEnd)
end

function var_0_0._refreshTabs(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._selectSecondTabId
	local var_10_1 = arg_10_0._selectThirdTabId

	arg_10_0._selectSecondTabId = 0
	arg_10_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_10_1) then
		arg_10_1 = arg_10_0.viewContainer:getSelectFirstTabId()
	end

	local var_10_2
	local var_10_3

	var_10_3, arg_10_0._selectSecondTabId, arg_10_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_10_1)

	local var_10_4 = StoreConfig.instance:getTabConfig(arg_10_0._selectThirdTabId)
	local var_10_5 = StoreConfig.instance:getTabConfig(arg_10_0._selectSecondTabId)
	local var_10_6 = StoreConfig.instance:getTabConfig(arg_10_0.viewContainer:getSelectFirstTabId())
	local var_10_7 = {}

	if var_10_4 and not string.nilorempty(var_10_4.showCost) then
		var_10_7 = string.splitToNumber(var_10_4.showCost, "#")
	elseif var_10_5 and not string.nilorempty(var_10_5.showCost) then
		var_10_7 = string.splitToNumber(var_10_5.showCost, "#")
	elseif var_10_6 and not string.nilorempty(var_10_6.showCost) then
		var_10_7 = string.splitToNumber(var_10_6.showCost, "#")
	end

	local var_10_8 = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)

	if var_10_8[1] then
		table.insert(var_10_7, {
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.Item,
			id = var_10_8[1].id
		})

		local var_10_9 = 0
		local var_10_10 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_10_8[1].id)

		if var_10_10 and not string.nilorempty(var_10_10.expireTime) then
			local var_10_11 = TimeUtil.stringToTimestamp(var_10_10.expireTime)
			local var_10_12 = math.floor(var_10_11 - ServerTime.now())

			if var_10_12 >= 0 and var_10_12 <= 259200 then
				var_10_9 = math.floor(var_10_12 / 60 / 60)
				var_10_9 = math.max(var_10_9, 1)
			end
		end

		if var_10_9 > 0 then
			gohelper.setActive(arg_10_0._godeduction, true)

			arg_10_0._txtdeduction.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_deduction_item_deadtime"), tostring(var_10_9))
		else
			gohelper.setActive(arg_10_0._godeduction, false)
		end
	else
		gohelper.setActive(arg_10_0._godeduction, false)
	end

	arg_10_0.viewContainer:setCurrencyByParams(var_10_7)

	if not arg_10_2 and var_10_0 == arg_10_0._selectSecondTabId and var_10_1 == arg_10_0._selectThirdTabId then
		return
	end

	local var_10_13 = StoreModel.instance:getSecondTabs(arg_10_0._selectFirstTabId, true, true)

	if var_10_13 and #var_10_13 > 0 then
		for iter_10_0 = 1, #var_10_13 do
			arg_10_0:_refreshSecondTabs(iter_10_0, var_10_13[iter_10_0])
			gohelper.setActive(arg_10_0._categoryItemContainer[iter_10_0].go, true)
		end

		for iter_10_1 = #var_10_13 + 1, #arg_10_0._categoryItemContainer do
			gohelper.setActive(arg_10_0._categoryItemContainer[iter_10_1].go, false)
		end
	else
		for iter_10_2 = 1, #arg_10_0._categoryItemContainer do
			gohelper.setActive(arg_10_0._categoryItemContainer[iter_10_2].go, false)
		end
	end

	arg_10_0:_onRefreshRedDot()
	arg_10_0:_refreshGoods(true)

	arg_10_0._scrollprop.verticalNormalizedPosition = 1
end

function var_0_0._refreshSecondTabs(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._categoryItemContainer[arg_11_1] or arg_11_0:initCategoryItemTable(arg_11_1)

	var_11_0.tabId = arg_11_2.id
	var_11_0.txt_itemcn1.text = arg_11_2.name
	var_11_0.txt_itemcn2.text = arg_11_2.name
	var_11_0.txt_itemen1.text = arg_11_2.nameEn
	var_11_0.txt_itemen2.text = arg_11_2.nameEn

	local var_11_1 = arg_11_0._selectSecondTabId == arg_11_2.id

	gohelper.setActive(var_11_0.go_unselected, not var_11_1)
	gohelper.setActive(var_11_0.go_selected, var_11_1)

	local var_11_2 = StoreModel.instance:getThirdTabs(arg_11_2.id, true, true)

	gohelper.setActive(var_11_0.go_line, var_11_1 and #var_11_2 > 0)

	if var_11_1 and var_11_2 and #var_11_2 > 0 then
		for iter_11_0 = 1, #var_11_2 do
			arg_11_0:_refreshThirdTabs(var_11_0, iter_11_0, var_11_2[iter_11_0])
			gohelper.setActive(var_11_0.childItemContainer[iter_11_0].go, true)
		end

		for iter_11_1 = #var_11_2 + 1, #var_11_0.childItemContainer do
			gohelper.setActive(var_11_0.childItemContainer[iter_11_1].go, false)
		end
	else
		for iter_11_2 = 1, #var_11_0.childItemContainer do
			gohelper.setActive(var_11_0.childItemContainer[iter_11_2].go, false)
		end
	end
end

function var_0_0.initCategoryItemTable(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = gohelper.cloneInPlace(arg_12_0._gostorecategoryitem, "item" .. arg_12_1)
	var_12_0.go_unselected = gohelper.findChild(var_12_0.go, "go_unselected")
	var_12_0.go_selected = gohelper.findChild(var_12_0.go, "go_selected")
	var_12_0.go_line = gohelper.findChild(var_12_0.go, "go_line")
	var_12_0.go_reddot = gohelper.findChild(var_12_0.go, "go_selected/txt_itemcn2/go_catereddot")
	var_12_0.go_unselectreddot = gohelper.findChild(var_12_0.go, "go_unselected/txt_itemcn1/go_unselectreddot")
	var_12_0.txt_itemcn1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemcn1")
	var_12_0.txt_itemen1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemen1")
	var_12_0.txt_itemcn2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemcn2")
	var_12_0.txt_itemen2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemen2")
	var_12_0.go_childcategory = gohelper.findChild(var_12_0.go, "go_childcategory")
	var_12_0.go_childItem = gohelper.findChild(var_12_0.go, "go_childcategory/go_childitem")
	var_12_0.childItemContainer = {}
	var_12_0.btnGO = gohelper.findChild(var_12_0.go, "clickArea")
	var_12_0.btn = gohelper.getClick(var_12_0.btnGO)
	var_12_0.tabId = 0

	var_12_0.btn:AddClickListener(function(arg_13_0)
		local var_13_0 = arg_13_0.tabId

		arg_12_0:_refreshTabs(var_13_0)
		StoreController.instance:statSwitchStore(var_13_0)
	end, var_12_0)
	table.insert(arg_12_0._categoryItemContainer, var_12_0)
	gohelper.setActive(var_12_0.go_childItem, false)

	return var_12_0
end

function var_0_0._refreshThirdTabs(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_1.childItemContainer[arg_14_2]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_1.go_childItem, "item" .. arg_14_2)
		var_14_0.go_unselected = gohelper.findChild(var_14_0.go, "go_unselected")
		var_14_0.go_selected = gohelper.findChild(var_14_0.go, "go_selected")
		var_14_0.go_subreddot1 = gohelper.findChild(var_14_0.go, "go_unselected/txt_itemcn1/go_subcatereddot")
		var_14_0.go_subreddot2 = gohelper.findChild(var_14_0.go, "go_selected/txt_itemcn2/go_subcatereddot")
		var_14_0.txt_itemcn1 = gohelper.findChildText(var_14_0.go, "go_unselected/txt_itemcn1")
		var_14_0.txt_itemen1 = gohelper.findChildText(var_14_0.go, "go_unselected/txt_itemen1")
		var_14_0.txt_itemcn2 = gohelper.findChildText(var_14_0.go, "go_selected/txt_itemcn2")
		var_14_0.txt_itemen2 = gohelper.findChildText(var_14_0.go, "go_selected/txt_itemen2")
		var_14_0.btnGO = gohelper.findChild(var_14_0.go, "clickArea")
		var_14_0.btn = gohelper.getClick(var_14_0.btnGO)
		var_14_0.tabId = 0

		var_14_0.btn:AddClickListener(function(arg_15_0)
			local var_15_0 = arg_15_0.tabId

			arg_14_0:_refreshTabs(var_15_0, nil, true)
			StoreController.instance:statSwitchStore(var_15_0)
		end, var_14_0)
		table.insert(arg_14_1.childItemContainer, var_14_0)
	end

	var_14_0.tabId = arg_14_3.id
	var_14_0.txt_itemcn1.text = arg_14_3.name
	var_14_0.txt_itemcn2.text = arg_14_3.name
	var_14_0.txt_itemen1.text = arg_14_3.nameEn
	var_14_0.txt_itemen2.text = arg_14_3.nameEn

	local var_14_1 = arg_14_0._selectThirdTabId == arg_14_3.id

	gohelper.setActive(var_14_0.go_unselected, not var_14_1)
	gohelper.setActive(var_14_0.go_selected, var_14_1)
end

function var_0_0._refreshGoods(arg_16_0, arg_16_1)
	if arg_16_1 then
		local var_16_0 = StoreConfig.instance:getTabConfig(arg_16_0._selectThirdTabId)

		arg_16_0.storeId = var_16_0 and var_16_0.storeId or 0

		if arg_16_0.storeId == 0 then
			local var_16_1 = StoreConfig.instance:getTabConfig(arg_16_0._selectSecondTabId)

			arg_16_0.storeId = var_16_1 and var_16_1.storeId or 0
		end

		StoreRpc.instance:sendGetStoreInfosRequest({
			arg_16_0.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
	end
end

function var_0_0._onRefreshRedDot(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._categoryItemContainer) do
		gohelper.setActive(iter_17_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_17_1.tabId))
		gohelper.setActive(iter_17_1.go_unselectreddot, StoreModel.instance:isTabFirstRedDotShow(iter_17_1.tabId))

		for iter_17_2, iter_17_3 in pairs(iter_17_1.childItemContainer) do
			gohelper.setActive(iter_17_3.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(iter_17_3.tabId))
			gohelper.setActive(iter_17_3.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(iter_17_3.tabId))
		end
	end
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0._selectFirstTabId = arg_18_0.viewContainer:getSelectFirstTabId()

	local var_18_0 = arg_18_0.viewContainer:getJumpTabId()
	local var_18_1 = arg_18_0.viewContainer:getJumpGoodsId()

	arg_18_0:_refreshTabs(var_18_0, true)
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_18_0._onRefreshRedDot, arg_18_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_18_0._updateItemList, arg_18_0)

	if var_18_1 then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(var_18_1))
		})
	end

	arg_18_0._scrollprop.horizontalNormalizedPosition = 0
end

function var_0_0._updateItemList(arg_19_0)
	local var_19_0 = arg_19_0.viewContainer:getJumpTabId()

	arg_19_0:_refreshTabs(var_19_0, true)
end

function var_0_0._updateInfo(arg_20_0)
	return
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, arg_21_0._isSkinEmpty, arg_21_0)
	arg_21_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_21_0._payFinished, arg_21_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_21_0._updateItemList, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_21_0._updateInfo, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_21_0._updateInfo, arg_21_0)
	arg_21_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_21_0._onRefreshRedDot, arg_21_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_21_0._updateItemList, arg_21_0)
end

function var_0_0.onUpdateParam(arg_22_0)
	arg_22_0._selectFirstTabId = arg_22_0.viewContainer:getSelectFirstTabId()

	local var_22_0 = arg_22_0.viewContainer:getJumpTabId()
	local var_22_1 = arg_22_0.viewContainer:getJumpGoodsId()

	arg_22_0:_refreshTabs(var_22_0)

	if var_22_1 then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(var_22_1))
		})
	end
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._categoryItemContainer and #arg_23_0._categoryItemContainer > 0 then
		for iter_23_0 = 1, #arg_23_0._categoryItemContainer do
			local var_23_0 = arg_23_0._categoryItemContainer[iter_23_0]

			var_23_0.btn:RemoveClickListener()

			if var_23_0.childItemContainer and #var_23_0.childItemContainer > 0 then
				for iter_23_1 = 1, #var_23_0.childItemContainer do
					var_23_0.childItemContainer[iter_23_1].btn:RemoveClickListener()
				end
			end
		end
	end

	arg_23_0._simagebg:UnLoadImage()
end

return var_0_0
