module("modules.logic.store.view.StoreSummonView", package.seeall)

slot0 = class("StoreSummonView", BaseView)

function slot0.onInitView(slot0)
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#scroll_prop/#go_lock")
	slot0._lineGo = gohelper.findChild(slot0.viewGO, "line")
	slot0._txtLockText = gohelper.findChildText(slot0.viewGO, "#scroll_prop/#go_lock/locktext")
	slot0._simagelockbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtrefreshTime = gohelper.findChildText(slot0.viewGO, "#txt_refreshTime")

	gohelper.setActive(slot0._gostorecategoryitem, false)

	slot0._lockClick = gohelper.getClickWithAudio(slot0._golock)
	slot0._isLock = false
	slot0._categoryItemContainer = {}

	slot0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot0._categoryItemContainer[slot4].btn:RemoveClickListener()
		end
	end

	slot0._simagelockbg:UnLoadImage()
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:AddClickListener(slot0._onLockClick, slot0)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0._refreshTabs(slot0, slot1, slot2)
	StoreController.instance:readTab(slot1)

	slot3 = slot0._selectSecondTabId
	slot4 = slot0._selectThirdTabId
	slot0._selectSecondTabId = 0
	slot0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot5 = nil
	slot5, slot0._selectSecondTabId, slot0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(slot1)

	slot0:refreshCurrency()

	if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
		return
	end

	slot0:refreshSubTabItems()
	slot0:_onRefreshRedDot()
	slot0:_refreshGoods(true)
	slot0:refreshLockStatus()
	slot0:refreshRemainTime()

	slot0._scrollprop.verticalNormalizedPosition = 1
end

function slot0.refreshCurrency(slot0)
	slot2 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
	slot3 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

	if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot1.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot1.showCost))
	elseif slot2 and not string.nilorempty(slot2.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot2.showCost))
	elseif slot3 and not string.nilorempty(slot3.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot3.showCost))
	else
		slot0.viewContainer:setCurrencyType(nil)
	end
end

function slot0.packShowCostParam(slot0, slot1)
	slot2 = {}

	for slot7 = #string.split(slot1, "#"), 1, -1 do
		table.insert(slot2, {
			isCurrencySprite = true,
			id = tonumber(slot3[slot7]),
			type = MaterialEnum.MaterialType.Item
		})
	end

	return slot2
end

function slot0.refreshRemainTime(slot0)
	if StoreHelper.getRemainExpireTime(StoreConfig.instance:getTabConfig(slot0._selectFirstTabId)) and slot3 > 0 then
		slot0._txtrefreshTime.text = string.format(luaLang("summon_limit_shop_remaintime"), SummonModel.formatRemainTime(slot3))
	else
		slot0._txtrefreshTime.text = ""
	end
end

function slot0.refreshSubTabItems(slot0)
	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot1 > 0 then
		for slot5 = 1, #slot1 do
			slot0:_refreshSecondTabs(slot5, slot1[slot5])
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, true)
		end

		gohelper.setActive(slot0._categoryItemContainer[#slot1].go_line, false)

		for slot5 = #slot1 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end

		gohelper.setActive(slot0._lineGo, true)
	else
		for slot5 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end

		gohelper.setActive(slot0._lineGo, false)
	end
end

function slot0.refreshLockStatus(slot0)
	if slot0._selectThirdTabId > 0 then
		slot0._isLock = StoreModel.instance:isStoreTabLock(slot0._selectThirdTabId)

		if slot0._isLock then
			slot0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(StoreConfig.instance:getStoreConfig(slot0._selectThirdTabId).needClearStore).name)
		end

		gohelper.setActive(slot0._golock, slot0._isLock)
	else
		gohelper.setActive(slot0._golock, false)
	end
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
	slot3 = slot0._categoryItemContainer[slot1] or slot0:initCategoryItemTable(slot1)
	slot3.tabId = slot2.id
	slot3.txt_itemcn1.text = slot2.name
	slot3.txt_itemcn2.text = slot2.name
	slot3.txt_itemen1.text = slot2.nameEn
	slot3.txt_itemen2.text = slot2.nameEn

	gohelper.setActive(slot0._categoryItemContainer[slot1].go_line, true)

	if slot0._selectSecondTabId == slot2.id and slot0._categoryItemContainer[slot1 - 1] then
		gohelper.setActive(slot0._categoryItemContainer[slot1 - 1].go_line, false)
	end

	gohelper.setActive(slot3.go_unselected, not slot4)
	gohelper.setActive(slot3.go_selected, slot4)
end

function slot0.initCategoryItemTable(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gostorecategoryitem, "item" .. slot1)
	slot2.go_unselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.go_selected = gohelper.findChild(slot2.go, "go_selected")
	slot2.go_reddot = gohelper.findChild(slot2.go, "#go_tabreddot1")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_line = gohelper.findChild(slot2.go, "#go_line")
	slot2.btn = gohelper.getClickWithAudio(slot2.go, AudioEnum.UI.play_ui_bank_open)
	slot2.tabId = 0

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		uv0:_refreshTabs(slot1)

		uv0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(slot1)
	end, slot2)
	table.insert(slot0._categoryItemContainer, slot2)
	gohelper.setActive(slot2.go_childItem, false)

	return slot2
end

function slot0._refreshGoods(slot0, slot1)
	slot0.storeId = 0
	slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and slot2.storeId or 0

	if slot0.storeId == 0 then
		slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId) and slot3.storeId or 0
	end

	if slot0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	else
		if StoreModel.instance:getStoreMO(slot0.storeId) then
			StoreNormalGoodsItemListModel.instance:setMOList(slot3:getGoodsList(true))
		end

		if slot1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				slot0.storeId
			})
			slot0.viewContainer:playNormalStoreAnimation()
		end
	end
end

function slot0._onLockClick(slot0)
	if slot0._isLock then
		GameFacade.showToast(ToastEnum.NormalStoreIsLock, StoreConfig.instance:getTabConfig(slot0.storeId).name)
	end
end

function slot0._updateInfo(slot0)
	slot0:_refreshGoods(false)
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		gohelper.setActive(slot5.go_reddot, StoreModel.instance:isTabFirstRedDotShow(slot5.tabId))
	end
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId())
end

return slot0
