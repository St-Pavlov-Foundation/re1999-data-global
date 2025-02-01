module("modules.logic.gm.view.GM_RecommendStoreViewContainer", package.seeall)

slot0 = class("GM_RecommendStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_RecommendStoreView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot1(slot0)
	return function (slot0)
		slot1 = StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true)
		slot2 = {
			[slot7] = true
		}

		for slot6, slot7 in ipairs(uv0) do
			-- Nothing
		end

		slot3, slot4 = StoreHelper.getRecommendStoreSecondTabConfig()
		slot5 = {}

		for slot9, slot10 in ipairs(slot1) do
			if slot2[slot10.id] then
				table.insert(slot5, slot10)
			end
		end

		table.sort(slot5, function (slot0, slot1)
			return uv0:_tabSortFunction(slot0, slot1)
		end)

		slot6 = false

		for slot10, slot11 in ipairs(slot5) do
			if slot11.id == slot0._selectSecondTabId then
				slot6 = true

				break
			end
		end

		if not slot6 then
			slot0._selectSecondTabId = slot5[1].id
		end

		slot7 = {}

		for slot11 = 1, #slot5 do
			slot0:_refreshSecondTabs(slot11, slot5[slot11])
			gohelper.setActive(slot0._categoryItemContainer[slot11].go, true)
			gohelper.setActive(slot0._categoryItemContainer[slot11].sliderGo, true)

			if slot0._categoryItemContainer[slot11].go.transform.rect.width > 0 then
				slot13 = slot12
				slot14 = 0

				if slot11 > 1 and slot0._categoryItemContainer[slot11 - 1] and slot7[slot11 - 1] and slot7[slot11 - 1].totalWidth then
					slot14 = -(slot7[slot11 - 1].totalWidth + slot12) + slot0._categoryscroll.transform.rect.width
				end

				slot7[slot11] = {
					width = slot12,
					totalWidth = slot13,
					pos = Mathf.Min(slot14, 0)
				}
			end
		end

		gohelper.setActive(slot0._categoryItemContainer[#slot5].go_line, false)

		for slot11 = #slot5 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot11].go, false)
			gohelper.setActive(slot0._categoryItemContainer[slot11].sliderGo, false)
		end

		if slot7 and slot7[slot0._nowIndex] and slot7[slot0._nowIndex].pos then
			recthelper.setAnchorX(slot0._categorycontentTrans, slot7[slot0._nowIndex].pos)
		else
			slot8 = -300 * (slot0._nowIndex - 5) - 50

			if recthelper.getAnchorX(slot0._categorycontentTrans) < -300 * (slot0._nowIndex - 1) then
				recthelper.setAnchorX(slot0._categorycontentTrans, slot9)
			elseif slot8 < slot10 then
				recthelper.setAnchorX(slot0._categorycontentTrans, slot8)
			end
		end

		slot0:_onRefreshRedDot()

		return slot4
	end
end

function slot2(slot0, slot1)
	RecommendStoreView._refreshTabsItem = slot0 and uv0(slot1) or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_refreshTabsItem")
end

function slot3()
	return function (slot0, slot1, slot2)
		if false then
			TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
			TaskDispatcher.runDelay(slot0._toNextTab, slot0, RecommendStoreView.AutoToNextTime)
		end

		slot3 = slot0._selectSecondTabId
		slot4 = slot0._selectThirdTabId
		slot0._selectSecondTabId = slot1
		slot0._selectThirdTabId = 0
		slot6 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
		slot7 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

		if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot5.showCost) then
			slot0.viewContainer:setCurrencyType(slot5.showCost)
		elseif slot6 and not string.nilorempty(slot6.showCost) then
			slot0.viewContainer:setCurrencyType(slot6.showCost)
		elseif slot7 and not string.nilorempty(slot7.showCost) then
			slot0.viewContainer:setCurrencyType(slot7.showCost)
		else
			slot0.viewContainer:setCurrencyType(nil)
		end

		if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
			return
		end

		if #slot0:_refreshTabsItem() > 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(slot8)
		end

		slot0:refreshRightPage()
	end
end

function slot4(slot0)
	RecommendStoreView._refreshTabs = slot0 and uv0() or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_refreshTabs")
	RecommendStoreView._onSetVisibleInternal = slot0 and function ()
	end or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_onSetVisibleInternal")
	RecommendStoreView._onSetAutoToNextPage = slot0 and function ()
	end or GMMinusModel.instance:getConst("GM_RecommendStoreViewContainer_Func_onSetAutoToNextPage")
end

function slot5()
	function RecommendStoreView._btngmOnClick(slot0)
		ViewMgr.instance:openView(ViewName.GM_RecommendStoreView)
	end

	function RecommendStoreView._showAllBannerUpdate(slot0, slot1)
		slot2 = {}

		if slot1 then
			slot3, slot4 = StoreHelper.getRecommendStoreSecondTabConfig()

			table.sort(slot3, function (slot0, slot1)
				return uv0:_tabSortFunction(slot0, slot1)
			end)

			for slot9 = 1, #slot3 do
				slot2[#slot2 + 1] = slot3[slot9].id
			end

			GMMinusModel.instance:setFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", {
				[slot11] = true
			})

			slot6 = ServerTime.now()

			for slot10, slot11 in ipairs(lua_store_recommend.configList) do
				slot13 = slot11.offlineTime
				slot14, slot15 = nil

				if slot6 <= (string.nilorempty(slot11.onlineTime) and slot6 or TimeUtil.stringToTimestamp(slot12)) and slot6 <= (string.nilorempty(slot13) and slot6 or TimeUtil.stringToTimestamp(slot13)) then
					slot2[#slot2 + 1] = slot11.id
				end
			end
		end

		uv0(slot1, slot2)
		slot0:_refreshTabsItem()
	end

	function RecommendStoreView._showAllTabIdUpdate(slot0)
		slot0:_refreshTabsItem()
	end

	function RecommendStoreView._stopBannerLoopAnimUpdate(slot0, slot1)
		if slot1 then
			TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
			TaskDispatcher.cancelTask(slot0._onSwitchCloseAnimDone, slot0)
		end

		uv0(slot1)
	end
end

function slot0._editableInitView(slot0)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_refreshTabsItem", RecommendStoreView._refreshTabsItem)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_refreshTabs", RecommendStoreView._refreshTabs)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_onSetVisibleInternal", RecommendStoreView._onSetVisibleInternal)
	GMMinusModel.instance:setConst("GM_RecommendStoreViewContainer_Func_onSetAutoToNextPage", RecommendStoreView._onSetAutoToNextPage)
	uv0()
end

function slot0.onOpen(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchCloseAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0._toNextTab, slot0)
	TaskDispatcher.runDelay(slot0._toNextTab, slot0, RecommendStoreView.AutoToNextTime)
	slot0:_showAllBannerUpdate(GM_RecommendStoreView.s_ShowAllBanner)
	slot0:_stopBannerLoopAnimUpdate(GM_RecommendStoreView.s_StopBannerLoopAnim)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, slot0._showAllBannerUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, slot0._showAllTabIdUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, slot0._stopBannerLoopAnimUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, slot0._showAllBannerUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, slot0._showAllTabIdUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, slot0._stopBannerLoopAnimUpdate, slot0)
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
	slot3 = slot0._categoryItemContainer[slot1]
	slot4 = slot2.id
	slot5 = slot2.name

	if GM_RecommendStoreView.s_ShowAllTabId then
		slot5 = (not GM_RecommendStoreView.s_ShowAllBanner or GMMinusModel.instance:getFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", {})[slot4] or string.format("%s\n<color=#00FF00>%s (New)</color>", slot5, slot4)) and string.format("%s\n%s", slot5, slot4)
	end

	slot3.txt_itemcn1.text = slot5
	slot3.txt_itemcn2.text = slot5
end

return slot0
