module("modules.logic.store.view.PackageStoreView", package.seeall)

local var_0_0 = class("PackageStoreView", BaseView)

function var_0_0._setActivtSoldOut(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._simageSoldoutGo, arg_1_1)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_bg")
	arg_2_0._gostorecategoryitem = gohelper.findChild(arg_2_0.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_2_0._scrollprop = gohelper.findChildScrollRect(arg_2_0.viewGO, "#scroll_prop")
	arg_2_0._gopropcontent = gohelper.findChild(arg_2_0.viewGO, "#scroll_prop/viewport/content")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageSoldoutGo = gohelper.findChild(arg_5_0.viewGO, "#simage_soldout")

	gohelper.setActive(arg_5_0._gostorecategoryitem, false)

	arg_5_0._categoryItemContainer = {}
	arg_5_0._horizontalNormalizedPosition = 0
	arg_5_0._scrollprop.horizontalNormalizedPosition = 0

	arg_5_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))
end

function var_0_0._refreshTabs(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0._selectSecondTabId
	local var_6_1 = arg_6_0._selectThirdTabId

	arg_6_0._selectSecondTabId = 0
	arg_6_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_6_1) then
		arg_6_1 = arg_6_0.viewContainer:getSelectFirstTabId()
	end

	local var_6_2
	local var_6_3

	var_6_3, arg_6_0._selectSecondTabId, arg_6_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_6_1)

	local var_6_4 = StoreConfig.instance:getTabConfig(arg_6_0._selectThirdTabId)
	local var_6_5 = StoreConfig.instance:getTabConfig(arg_6_0._selectSecondTabId)
	local var_6_6 = StoreConfig.instance:getTabConfig(arg_6_0.viewContainer:getSelectFirstTabId())

	if var_6_4 and not string.nilorempty(var_6_4.showCost) then
		arg_6_0.viewContainer:setCurrencyType(var_6_4.showCost)
	elseif var_6_5 and not string.nilorempty(var_6_5.showCost) then
		arg_6_0.viewContainer:setCurrencyType(var_6_5.showCost)
	elseif var_6_6 and not string.nilorempty(var_6_6.showCost) then
		arg_6_0.viewContainer:setCurrencyType(var_6_6.showCost)
	else
		arg_6_0.viewContainer:setCurrencyType(nil)
	end

	if not arg_6_2 and var_6_0 == arg_6_0._selectSecondTabId and var_6_1 == arg_6_0._selectThirdTabId then
		return
	end

	arg_6_0:_refreshAllSecondTabs()
	StoreController.instance:readTab(arg_6_1)
	arg_6_0:_onRefreshRedDot()

	arg_6_0._resetScrollPos = true

	arg_6_0:_refreshGoods(true, arg_6_3)
end

function var_0_0._refreshAllSecondTabs(arg_7_0)
	local var_7_0 = StoreModel.instance:getSecondTabs(arg_7_0._selectFirstTabId, true, true)

	if var_7_0 and #var_7_0 > 0 then
		for iter_7_0 = 1, #var_7_0 do
			arg_7_0:_refreshSecondTabs(iter_7_0, var_7_0[iter_7_0])

			local var_7_1 = StoreModel.instance:getPackageGoodValidList(var_7_0[iter_7_0].id)

			gohelper.setActive(arg_7_0._categoryItemContainer[iter_7_0].go, #var_7_1 > 0)
		end

		for iter_7_1 = #var_7_0 + 1, #arg_7_0._categoryItemContainer do
			gohelper.setActive(arg_7_0._categoryItemContainer[iter_7_1].go, false)
		end
	else
		for iter_7_2 = 1, #arg_7_0._categoryItemContainer do
			gohelper.setActive(arg_7_0._categoryItemContainer[iter_7_2].go, false)
		end
	end
end

function var_0_0._refreshSecondTabs(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._categoryItemContainer[arg_8_1] or arg_8_0:initCategoryItemTable(arg_8_1)

	var_8_0.tabId = arg_8_2.id
	var_8_0.txt_itemcn1.text = arg_8_2.name
	var_8_0.txt_itemcn2.text = arg_8_2.name
	var_8_0.txt_itemen1.text = arg_8_2.nameEn
	var_8_0.txt_itemen2.text = arg_8_2.nameEn

	local var_8_1 = arg_8_0._selectSecondTabId == arg_8_2.id

	gohelper.setActive(var_8_0.go_unselected, not var_8_1)
	gohelper.setActive(var_8_0.go_selected, var_8_1)

	local var_8_2 = StoreModel.instance:getThirdTabs(arg_8_2.id, true, true)

	gohelper.setActive(var_8_0.go_line, var_8_1 and #var_8_2 > 0)

	if var_8_1 and var_8_2 and #var_8_2 > 0 then
		for iter_8_0 = 1, #var_8_2 do
			arg_8_0:_refreshThirdTabs(var_8_0, iter_8_0, var_8_2[iter_8_0])
			gohelper.setActive(var_8_0.childItemContainer[iter_8_0].go, true)
		end

		for iter_8_1 = #var_8_2 + 1, #var_8_0.childItemContainer do
			gohelper.setActive(var_8_0.childItemContainer[iter_8_1].go, false)
		end
	else
		for iter_8_2 = 1, #var_8_0.childItemContainer do
			gohelper.setActive(var_8_0.childItemContainer[iter_8_2].go, false)
		end
	end
end

function var_0_0.initCategoryItemTable(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0._gostorecategoryitem, "item" .. arg_9_1)
	var_9_0.go_unselected = gohelper.findChild(var_9_0.go, "go_unselected")
	var_9_0.go_selected = gohelper.findChild(var_9_0.go, "go_selected")
	var_9_0.go_line = gohelper.findChild(var_9_0.go, "go_line")
	var_9_0.go_reddot = gohelper.findChild(var_9_0.go, "#go_tabreddot1")
	var_9_0.txt_itemcn1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemcn1")
	var_9_0.txt_itemen1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemen1")
	var_9_0.txt_itemcn2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemcn2")
	var_9_0.txt_itemen2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemen2")
	var_9_0.go_childcategory = gohelper.findChild(var_9_0.go, "go_childcategory")
	var_9_0.go_childItem = gohelper.findChild(var_9_0.go, "go_childcategory/go_childitem")
	var_9_0.childItemContainer = {}
	var_9_0.btnGO = gohelper.findChild(var_9_0.go, "clickArea")
	var_9_0.btn = gohelper.getClickWithAudio(var_9_0.go, AudioEnum.UI.play_ui_bank_open)
	var_9_0.tabId = 0

	var_9_0.btn:AddClickListener(function(arg_10_0)
		local var_10_0 = arg_10_0.tabId

		arg_9_0:_refreshTabs(var_10_0)
		StoreController.instance:statSwitchStore(var_10_0)
	end, var_9_0)
	table.insert(arg_9_0._categoryItemContainer, var_9_0)
	gohelper.setActive(var_9_0.go_childItem, false)

	return var_9_0
end

function var_0_0._refreshThirdTabs(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1.childItemContainer[arg_11_2]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = gohelper.cloneInPlace(arg_11_1.go_childItem, "item" .. arg_11_2)
		var_11_0.go_unselected = gohelper.findChild(var_11_0.go, "go_unselected")
		var_11_0.go_selected = gohelper.findChild(var_11_0.go, "go_selected")
		var_11_0.go_subreddot1 = gohelper.findChild(var_11_0.go, "go_unselected/txt_itemcn1/go_subcatereddot")
		var_11_0.go_subreddot2 = gohelper.findChild(var_11_0.go, "go_selected/txt_itemcn2/go_subcatereddot")
		var_11_0.txt_itemcn1 = gohelper.findChildText(var_11_0.go, "go_unselected/txt_itemcn1")
		var_11_0.txt_itemen1 = gohelper.findChildText(var_11_0.go, "go_unselected/txt_itemen1")
		var_11_0.txt_itemcn2 = gohelper.findChildText(var_11_0.go, "go_selected/txt_itemcn2")
		var_11_0.txt_itemen2 = gohelper.findChildText(var_11_0.go, "go_selected/txt_itemen2")
		var_11_0.btnGO = gohelper.findChild(var_11_0.go, "clickArea")
		var_11_0.btn = gohelper.getClick(var_11_0.btnGO)
		var_11_0.tabId = 0

		var_11_0.btn:AddClickListener(function(arg_12_0)
			local var_12_0 = arg_12_0.tabId

			arg_11_0:_refreshTabs(var_12_0, nil, true)
			StoreController.instance:statSwitchStore(var_12_0)
		end, var_11_0)
		table.insert(arg_11_1.childItemContainer, var_11_0)
	end

	var_11_0.tabId = arg_11_3.id
	var_11_0.txt_itemcn1.text = arg_11_3.name
	var_11_0.txt_itemcn2.text = arg_11_3.name
	var_11_0.txt_itemen1.text = arg_11_3.nameEn
	var_11_0.txt_itemen2.text = arg_11_3.nameEn

	local var_11_1 = arg_11_0._selectThirdTabId == arg_11_3.id

	gohelper.setActive(var_11_0.go_unselected, not var_11_1)
	gohelper.setActive(var_11_0.go_selected, var_11_1)
end

function var_0_0._refreshGoods(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_setActivtSoldOut(false)

	arg_13_0.storeId = 0

	local var_13_0 = StoreConfig.instance:getTabConfig(arg_13_0._selectThirdTabId)

	arg_13_0.storeId = var_13_0 and var_13_0.storeId or 0

	if arg_13_0.storeId == 0 then
		local var_13_1 = StoreConfig.instance:getTabConfig(arg_13_0._selectSecondTabId)

		arg_13_0.storeId = var_13_1 and var_13_1.storeId or 0
	end

	if arg_13_0.storeId == 0 then
		StorePackageGoodsItemListModel.instance:setMOList()
		arg_13_0:_setActivtSoldOut(true)
	elseif arg_13_0.storeId == StoreEnum.StoreId.RecommendPackage then
		StoreModel.instance:setCurPackageStore(arg_13_0.storeId)

		local var_13_2 = StoreModel.instance:getRecommendPackageList(true)

		StorePackageGoodsItemListModel.instance:setMOList(nil, var_13_2)
		arg_13_0:updateRecommendPackageList(arg_13_2)
	elseif arg_13_1 then
		StoreModel.instance:setCurPackageStore(arg_13_0.storeId)
		StoreModel.instance:setPackageStoreRpcNum(2)

		local var_13_3 = StoreModel.instance:storeId2PackageGoodMoList(arg_13_0.storeId)

		StorePackageGoodsItemListModel.instance:setMOList(StoreModel.instance:getStoreMO(arg_13_0.storeId), var_13_3, nil, true)
		StoreRpc.instance:sendGetStoreInfosRequest({
			arg_13_0.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
		arg_13_0.viewContainer:playNormalStoreAnimation()
	end
end

function var_0_0._onRefreshRedDot(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._categoryItemContainer) do
		if iter_14_1.tabId == StoreEnum.StoreId.RecommendPackage then
			gohelper.setActive(iter_14_1.go_reddot, StoreModel.instance:isTabFirstRedDotShow(iter_14_1.tabId))
		else
			gohelper.setActive(iter_14_1.go_reddot, StoreModel.instance:isPackageStoreTabRedDotShow(iter_14_1.tabId))
		end

		for iter_14_2, iter_14_3 in pairs(iter_14_1.childItemContainer) do
			gohelper.setActive(iter_14_3.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(iter_14_3.tabId))
			gohelper.setActive(iter_14_3.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(iter_14_3.tabId))
		end
	end
end

function var_0_0._beforeUpdatePackageStore(arg_15_0)
	arg_15_0._horizontalNormalizedPosition = arg_15_0._scrollprop.horizontalNormalizedPosition
end

function var_0_0._afterUpdatePackageStore(arg_16_0)
	arg_16_0._scrollprop.horizontalNormalizedPosition = arg_16_0._horizontalNormalizedPosition
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._selectFirstTabId = arg_17_0.viewContainer:getSelectFirstTabId()

	local var_17_0 = arg_17_0.viewContainer:getJumpTabId()
	local var_17_1 = arg_17_0.viewContainer:getJumpGoodsId()

	arg_17_0:_refreshTabs(var_17_0, true, true)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.BeforeUpdatePackageStore, arg_17_0._beforeUpdatePackageStore, arg_17_0)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.AfterUpdatePackageStore, arg_17_0._afterUpdatePackageStore, arg_17_0)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_17_0._updateInfo, arg_17_0)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_17_0._updateInfo, arg_17_0)
	arg_17_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_17_0._onRefreshRedDot, arg_17_0)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_17_0.onUpdatePackageGoodsList, arg_17_0)
	arg_17_0:addEventCb(StoreController.instance, StoreEvent.CurPackageListEmpty, arg_17_0.onPackageGoodsListEmpty, arg_17_0)
	arg_17_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_17_0._onFinishTask, arg_17_0)
	transformhelper.setLocalPos(arg_17_0._gopropcontent.transform, 0, 0, 0)

	if var_17_1 then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(var_17_1)))
	end
end

function var_0_0._updateInfo(arg_18_0)
	arg_18_0:_refreshGoods(false)
end

function var_0_0._onFinishTask(arg_19_0, arg_19_1)
	if StoreConfig.instance:getChargeConditionalConfig(arg_19_1) and not arg_19_0._isHasWaitRefeshGoodsTask then
		arg_19_0._isHasWaitRefeshGoodsTask = true

		TaskDispatcher.runDelay(arg_19_0._onRunWaitRefeshGoods, arg_19_0, 0.1)
	end
end

function var_0_0._onRunWaitRefeshGoods(arg_20_0)
	arg_20_0._isHasWaitRefeshGoodsTask = false

	arg_20_0:_refreshGoods(true)
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.BeforeUpdatePackageStore, arg_21_0._beforeUpdatePackageStore, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.AfterUpdatePackageStore, arg_21_0._afterUpdatePackageStore, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_21_0._updateInfo, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_21_0._updateInfo, arg_21_0)
	arg_21_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_21_0._onRefreshRedDot, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_21_0.onUpdatePackageGoodsList, arg_21_0)
	arg_21_0:removeEventCb(StoreController.instance, StoreEvent.CurPackageListEmpty, arg_21_0.onPackageGoodsListEmpty, arg_21_0)
	arg_21_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_21_0._onFinishTask, arg_21_0)

	if arg_21_0._isHasWaitRefeshGoodsTask then
		arg_21_0._isHasWaitRefeshGoodsTask = nil

		TaskDispatcher.cancelTask(arg_21_0._onRunWaitRefeshGoods, arg_21_0)
	end
end

function var_0_0.onUpdateParam(arg_22_0)
	arg_22_0._selectFirstTabId = arg_22_0.viewContainer:getSelectFirstTabId()

	local var_22_0 = arg_22_0.viewContainer:getJumpTabId()
	local var_22_1 = arg_22_0.viewContainer:getJumpGoodsId()

	arg_22_0:_refreshTabs(var_22_0)

	if var_22_1 then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(var_22_1)))
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

function var_0_0.onUpdatePackageGoodsList(arg_24_0)
	arg_24_0:_refreshAllSecondTabs()
	arg_24_0:_onRefreshRedDot()
	arg_24_0:refreshScrollViewPos(false)
end

function var_0_0.updateRecommendPackageList(arg_25_0, arg_25_1)
	local var_25_0 = StoreModel.instance:getCurBuyPackageId()
	local var_25_1 = StorePackageGoodsItemListModel.instance:getList()

	if (not var_25_1 or #var_25_1 == 0) and var_25_0 == nil then
		arg_25_0:_refreshTabs(StoreEnum.StoreId.Package, true)

		return
	end

	arg_25_0:_onRefreshRedDot()
	arg_25_0:refreshScrollViewPos(arg_25_1)
end

function var_0_0.onPackageGoodsListEmpty(arg_26_0)
	arg_26_0:_refreshTabs(StoreEnum.StoreId.Package, true)
end

function var_0_0.refreshScrollViewPos(arg_27_0, arg_27_1)
	local var_27_0 = StoreModel.instance:isPackageStoreTabRedDotShow(arg_27_0._selectSecondTabId)

	if arg_27_1 or var_27_0 then
		local var_27_1 = StorePackageGoodsItemListModel.instance:getList()

		for iter_27_0, iter_27_1 in ipairs(var_27_1) do
			local var_27_2 = iter_27_1.goodsId

			if StoreModel.instance:isGoodsItemRedDotShow(var_27_2) then
				arg_27_0._scrollprop.horizontalNormalizedPosition = (iter_27_0 - 1) / (#var_27_1 - 1)

				return
			end
		end
	end

	if arg_27_0._resetScrollPos then
		arg_27_0._scrollprop.horizontalNormalizedPosition = 0
		arg_27_0._resetScrollPos = false
	end
end

return var_0_0
