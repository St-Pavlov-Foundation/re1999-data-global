module("modules.logic.store.view.NormalStoreView", package.seeall)

slot0 = class("NormalStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#scroll_prop/#go_lock")
	slot0._simagelockbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._goline = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	slot0._gotabreddot1 = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	slot0._golimit = gohelper.findChild(slot0.viewGO, "#go_limit")
	slot0._txtrefreshTime = gohelper.findChildText(slot0.viewGO, "#txt_refreshTime")

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

	gohelper.setActive(slot0._txtrefreshTime.gameObject, false)
	gohelper.setActive(slot0._gostorecategoryitem, false)

	slot0._lockClick = gohelper.getClickWithAudio(slot0._golock)
	slot0._isLock = false
	slot0._categoryItemContainer = {}

	slot0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
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

	if slot0._selectSecondTabId == StoreEnum.StoreId.LimitStore then
		slot0:refreshCurrency()
	else
		slot8 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
		slot9 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

		if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot7.showCost) then
			slot0.viewContainer:setCurrencyType(slot7.showCost)
		elseif slot8 and not string.nilorempty(slot8.showCost) then
			slot0.viewContainer:setCurrencyType(slot8.showCost)
		elseif slot9 and not string.nilorempty(slot9.showCost) then
			slot0.viewContainer:setCurrencyType(slot9.showCost)
		else
			slot0.viewContainer:setCurrencyType(nil)
		end
	end

	if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
		return
	end

	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot7 > 0 then
		for slot11 = 1, #slot7 do
			slot0:_refreshSecondTabs(slot11, slot7[slot11])
			gohelper.setActive(slot0._categoryItemContainer[slot11].go, true)
		end

		gohelper.setActive(slot0._categoryItemContainer[#slot7].go_line, false)

		for slot11 = #slot7 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot11].go, false)
		end

		gohelper.setActive(slot0._lineGo, true)
	else
		for slot11 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot11].go, false)
		end

		gohelper.setActive(slot0._lineGo, false)
	end

	slot0:_onRefreshRedDot()
	slot0:_refreshTabDeadLine()
	slot0:_refreshGoods(true)

	if slot0._selectThirdTabId > 0 then
		slot0._isLock = StoreModel.instance:isStoreTabLock(slot0._selectThirdTabId)

		if slot0._isLock then
			slot0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(StoreConfig.instance:getStoreConfig(slot0._selectThirdTabId).needClearStore).name)
		end

		gohelper.setActive(slot0._golock, slot0._isLock)
	else
		gohelper.setActive(slot0._golock, false)
	end

	slot0._scrollprop.verticalNormalizedPosition = 1

	gohelper.setActive(slot0._golimit, slot6)
	gohelper.setActive(slot0._scrollprop.gameObject, not slot6)
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
		if ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot3[slot7]) then
			table.insert(slot2, {
				isCurrencySprite = true,
				id = tonumber(slot8),
				icon = slot9.icon,
				type = MaterialEnum.MaterialType.Item
			})
		end
	end

	return slot2
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
	slot2.go_reddotNormalType = gohelper.findChild(slot2.go, "#go_tabreddot1/type1")
	slot2.go_reddotActType = gohelper.findChild(slot2.go, "#go_tabreddot1/type9")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_line = gohelper.findChild(slot2.go, "#go_line")
	slot2.go_deadline = gohelper.findChild(slot2.go, "go_deadline")
	slot2.imagetimebg = gohelper.findChildImage(slot2.go, "go_deadline/timebg")
	slot2.godeadlineEffect = gohelper.findChild(slot2.go, "go_deadline/#effect")
	slot2.imagetimeicon = gohelper.findChildImage(slot2.go, "go_deadline/#txt_time/timeicon")
	slot2.txttime = gohelper.findChildText(slot2.go, "go_deadline/#txt_time")
	slot2.txtformat = gohelper.findChildText(slot2.go, "go_deadline/#txt_time/#txt_format")
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
			StoreNormalGoodsItemListModel.instance:setMOList(slot3:getGoodsList(true), slot0.storeId)
		else
			StoreNormalGoodsItemListModel.instance:setMOList(nil, slot0.storeId)
		end

		if slot1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				slot0.storeId
			})
			slot0.viewContainer:playNormalStoreAnimation()
			slot0.viewContainer:playSummonStoreAnimation()
		end
	end
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, slot0._updateInfo, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:AddClickListener(slot0._onLockClick, slot0)
	slot0:checkCountdownStatus()
end

function slot0._onLockClick(slot0)
	if slot0._isLock then
		GameFacade.showToast(ToastEnum.NormalStoreIsLock, StoreConfig.instance:getTabConfig(slot0.storeId).name)
	end
end

function slot0._updateInfo(slot0)
	slot0:_refreshGoods(false)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, slot0._updateInfo, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:RemoveClickListener()
	slot0:closeTaskCountdown()
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		slot6, slot7 = StoreModel.instance:isTabFirstRedDotShow(slot5.tabId)

		gohelper.setActive(slot5.go_reddot, slot6)
		gohelper.setActive(slot5.go_reddotNormalType, not slot7)
		gohelper.setActive(slot5.go_reddotActType, slot7)
	end
end

function slot0.checkCountdownStatus(slot0)
	if slot0._needCountdown then
		TaskDispatcher.cancelTask(slot0._refreshTabDeadLine, slot0)
		TaskDispatcher.runRepeat(slot0._refreshTabDeadLine, slot0, 1)
	end
end

function slot0.closeTaskCountdown(slot0)
	if slot0._needCountdown then
		TaskDispatcher.cancelTask(slot0._refreshTabDeadLine, slot0)
	end
end

function slot0._refreshTabDeadLine(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		if slot5 ~= nil or slot5.tabId ~= nil then
			if StoreHelper.getRemainExpireTime(StoreConfig.instance:getTabConfig(slot5.tabId)) > 0 then
				slot8 = false
				slot5.txttime.text, slot5.txtformat.text, slot8 = TimeUtil.secondToRoughTime(math.floor(slot7), true)

				if slot0._refreshTabDeadlineHasDay == nil then
					slot0._refreshTabDeadlineHasDay = {}
				end

				if slot0._refreshTabDeadlineHasDay[slot5.tabId] == nil or slot0._refreshTabDeadlineHasDay[slot5.tabId] ~= slot8 then
					UISpriteSetMgr.instance:setCommonSprite(slot5.imagetimebg, slot8 and "daojishi_01" or "daojishi_02")
					UISpriteSetMgr.instance:setCommonSprite(slot5.imagetimeicon, slot8 and "daojishiicon_01" or "daojishiicon_02")
					SLFramework.UGUI.GuiHelper.SetColor(slot5.txttime, slot8 and "#98D687" or "#E99B56")
					SLFramework.UGUI.GuiHelper.SetColor(slot5.txtformat, slot8 and "#98D687" or "#E99B56")
					gohelper.setActive(slot5.godeadlineEffect, not slot8)

					slot0._refreshTabDeadlineHasDay[slot5.tabId] = slot8
				end

				slot0._needCountdown = true
			end

			gohelper.setActive(slot5.go_deadline, slot7 > 0)
			gohelper.setActive(slot5.txttime.gameObject, slot7 > 0)
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId())
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot0._categoryItemContainer[slot4].btn:RemoveClickListener()
		end
	end

	slot0._simagelockbg:UnLoadImage()
end

return slot0
