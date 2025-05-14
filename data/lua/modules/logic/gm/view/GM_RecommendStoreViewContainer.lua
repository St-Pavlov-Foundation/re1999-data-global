module("modules.logic.gm.view.GM_RecommendStoreViewContainer", package.seeall)

local var_0_0 = class("GM_RecommendStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_RecommendStoreView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

local function var_0_1(arg_3_0)
	return function(arg_4_0)
		local var_4_0 = StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true)
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_3_0) do
			var_4_1[iter_4_1] = true
		end

		local var_4_2, var_4_3 = StoreHelper.getRecommendStoreSecondTabConfig()
		local var_4_4 = {}

		for iter_4_2, iter_4_3 in ipairs(var_4_0) do
			if var_4_1[iter_4_3.id] then
				table.insert(var_4_4, iter_4_3)
			end
		end

		table.sort(var_4_4, function(arg_5_0, arg_5_1)
			return arg_4_0:_tabSortFunction(arg_5_0, arg_5_1)
		end)

		local var_4_5 = false

		for iter_4_4, iter_4_5 in ipairs(var_4_4) do
			if iter_4_5.id == arg_4_0._selectSecondTabId then
				var_4_5 = true

				break
			end
		end

		if not var_4_5 then
			arg_4_0._selectSecondTabId = var_4_4[1].id
		end

		local var_4_6 = {}

		for iter_4_6 = 1, #var_4_4 do
			arg_4_0:_refreshSecondTabs(iter_4_6, var_4_4[iter_4_6])
			gohelper.setActive(arg_4_0._categoryItemContainer[iter_4_6].go, true)
			gohelper.setActive(arg_4_0._categoryItemContainer[iter_4_6].sliderGo, true)

			local var_4_7 = arg_4_0._categoryItemContainer[iter_4_6].go.transform.rect.width

			if var_4_7 > 0 then
				local var_4_8 = var_4_7
				local var_4_9 = 0

				if iter_4_6 > 1 and arg_4_0._categoryItemContainer[iter_4_6 - 1] and var_4_6[iter_4_6 - 1] and var_4_6[iter_4_6 - 1].totalWidth then
					var_4_8 = var_4_6[iter_4_6 - 1].totalWidth + var_4_7

					local var_4_10 = arg_4_0._categoryscroll.transform.rect.width

					var_4_9 = -var_4_8 + var_4_10
				end

				var_4_6[iter_4_6] = {
					width = var_4_7,
					totalWidth = var_4_8,
					pos = Mathf.Min(var_4_9, 0)
				}
			end
		end

		gohelper.setActive(arg_4_0._categoryItemContainer[#var_4_4].go_line, false)

		for iter_4_7 = #var_4_4 + 1, #arg_4_0._categoryItemContainer do
			gohelper.setActive(arg_4_0._categoryItemContainer[iter_4_7].go, false)
			gohelper.setActive(arg_4_0._categoryItemContainer[iter_4_7].sliderGo, false)
		end

		if var_4_6 and var_4_6[arg_4_0._nowIndex] and var_4_6[arg_4_0._nowIndex].pos then
			local var_4_11 = var_4_6[arg_4_0._nowIndex].pos

			recthelper.setAnchorX(arg_4_0._categorycontentTrans, var_4_11)
		else
			local var_4_12 = -300 * (arg_4_0._nowIndex - 5) - 50
			local var_4_13 = -300 * (arg_4_0._nowIndex - 1)
			local var_4_14 = recthelper.getAnchorX(arg_4_0._categorycontentTrans)

			if var_4_14 < var_4_13 then
				recthelper.setAnchorX(arg_4_0._categorycontentTrans, var_4_13)
			elseif var_4_12 < var_4_14 then
				recthelper.setAnchorX(arg_4_0._categorycontentTrans, var_4_12)
			end
		end

		arg_4_0:_onRefreshRedDot()

		return var_4_3
	end
end

local function var_0_2(arg_6_0, arg_6_1)
	RecommendStoreView._refreshTabsItem = arg_6_0 and var_0_1(arg_6_1) or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_refreshTabsItem")
end

local function var_0_3()
	return function(arg_8_0, arg_8_1, arg_8_2)
		if false then
			TaskDispatcher.cancelTask(arg_8_0._toNextTab, arg_8_0)
			TaskDispatcher.runDelay(arg_8_0._toNextTab, arg_8_0, RecommendStoreView.AutoToNextTime)
		end

		local var_8_0 = arg_8_0._selectSecondTabId
		local var_8_1 = arg_8_0._selectThirdTabId

		arg_8_0._selectSecondTabId = arg_8_1
		arg_8_0._selectThirdTabId = 0

		local var_8_2 = StoreConfig.instance:getTabConfig(arg_8_0._selectThirdTabId)
		local var_8_3 = StoreConfig.instance:getTabConfig(arg_8_0._selectSecondTabId)
		local var_8_4 = StoreConfig.instance:getTabConfig(arg_8_0.viewContainer:getSelectFirstTabId())

		if var_8_2 and not string.nilorempty(var_8_2.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_2.showCost)
		elseif var_8_3 and not string.nilorempty(var_8_3.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_3.showCost)
		elseif var_8_4 and not string.nilorempty(var_8_4.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_4.showCost)
		else
			arg_8_0.viewContainer:setCurrencyType(nil)
		end

		if not arg_8_2 and var_8_0 == arg_8_0._selectSecondTabId and var_8_1 == arg_8_0._selectThirdTabId then
			return
		end

		local var_8_5 = arg_8_0:_refreshTabsItem()

		if #var_8_5 > 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(var_8_5)
		end

		arg_8_0:refreshRightPage()
	end
end

local function var_0_4(arg_9_0)
	RecommendStoreView._refreshTabs = arg_9_0 and var_0_3() or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_refreshTabs")
	RecommendStoreView._onSetVisibleInternal = arg_9_0 and function()
		return
	end or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_onSetVisibleInternal")
	RecommendStoreView._onSetAutoToNextPage = arg_9_0 and function()
		return
	end or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_onSetAutoToNextPage")
end

local function var_0_5()
	function RecommendStoreView._btngmOnClick(arg_13_0)
		ViewMgr.instance:openView(ViewName.GM_RecommendStoreView)
	end

	function RecommendStoreView._showAllBannerUpdate(arg_14_0, arg_14_1)
		local var_14_0 = {}

		if arg_14_1 then
			local var_14_1, var_14_2 = StoreHelper.getRecommendStoreSecondTabConfig()

			table.sort(var_14_1, function(arg_15_0, arg_15_1)
				return arg_14_0:_tabSortFunction(arg_15_0, arg_15_1)
			end)

			local var_14_3 = {}

			for iter_14_0 = 1, #var_14_1 do
				local var_14_4 = var_14_1[iter_14_0].id

				var_14_0[#var_14_0 + 1] = var_14_4
				var_14_3[var_14_4] = true
			end

			GMMinusModel.instance:setFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", var_14_3)

			local var_14_5 = ServerTime.now()

			for iter_14_1, iter_14_2 in ipairs(lua_store_recommend.configList) do
				local var_14_6 = iter_14_2.onlineTime
				local var_14_7 = iter_14_2.offlineTime
				local var_14_8
				local var_14_9

				if string.nilorempty(var_14_6) then
					var_14_8 = var_14_5
				else
					var_14_8 = TimeUtil.stringToTimestamp(var_14_6)
				end

				if string.nilorempty(var_14_7) then
					var_14_9 = var_14_5
				else
					var_14_9 = TimeUtil.stringToTimestamp(var_14_7)
				end

				if var_14_5 <= var_14_8 and var_14_5 <= var_14_9 then
					var_14_0[#var_14_0 + 1] = iter_14_2.id
				end
			end
		end

		var_0_2(arg_14_1, var_14_0)
		arg_14_0:_refreshTabsItem()
	end

	function RecommendStoreView._showAllTabIdUpdate(arg_16_0)
		arg_16_0:_refreshTabsItem()
	end

	function RecommendStoreView._stopBannerLoopAnimUpdate(arg_17_0, arg_17_1)
		if arg_17_1 then
			TaskDispatcher.cancelTask(arg_17_0._toNextTab, arg_17_0)
			TaskDispatcher.cancelTask(arg_17_0._onSwitchCloseAnimDone, arg_17_0)
		end

		var_0_4(arg_17_1)
	end
end

function var_0_0._editableInitView(arg_18_0)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_refreshTabsItem", RecommendStoreView._refreshTabsItem)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_refreshTabs", RecommendStoreView._refreshTabs)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_onSetVisibleInternal", RecommendStoreView._onSetVisibleInternal)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_onSetAutoToNextPage", RecommendStoreView._onSetAutoToNextPage)
	var_0_5()
end

function var_0_0.onOpen(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._onSwitchCloseAnimDone, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._toNextTab, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._toNextTab, arg_19_0, RecommendStoreView.AutoToNextTime)
	arg_19_0:_showAllBannerUpdate(GM_RecommendStoreView.s_ShowAllBanner)
	arg_19_0:_stopBannerLoopAnimUpdate(GM_RecommendStoreView.s_StopBannerLoopAnim)
end

function var_0_0.addEvents(arg_20_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, arg_20_0._showAllBannerUpdate, arg_20_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, arg_20_0._showAllTabIdUpdate, arg_20_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, arg_20_0._stopBannerLoopAnimUpdate, arg_20_0)
end

function var_0_0.removeEvents(arg_21_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, arg_21_0._showAllBannerUpdate, arg_21_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, arg_21_0._showAllTabIdUpdate, arg_21_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, arg_21_0._stopBannerLoopAnimUpdate, arg_21_0)
end

function var_0_0._refreshSecondTabs(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._categoryItemContainer[arg_22_1]
	local var_22_1 = arg_22_2.id
	local var_22_2 = arg_22_2.name

	if GM_RecommendStoreView.s_ShowAllTabId then
		local var_22_3 = GMMinusModel.instance:getFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", {})

		if GM_RecommendStoreView.s_ShowAllBanner and not var_22_3[var_22_1] then
			var_22_2 = string.format("%s\n<color=#00FF00>%s (New)</color>", var_22_2, var_22_1)
		else
			var_22_2 = string.format("%s\n%s", var_22_2, var_22_1)
		end
	end

	var_22_0.txt_itemcn1.text = var_22_2
	var_22_0.txt_itemcn2.text = var_22_2
end

return var_0_0
