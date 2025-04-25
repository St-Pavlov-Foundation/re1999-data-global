module("modules.logic.store.view.RoomStoreView", package.seeall)

slot0 = class("RoomStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "#go_critter")
	slot0._trsviewport = gohelper.findChild(slot0.viewGO, "#scroll_prop/viewport").transform
	slot0._trscontent = gohelper.findChild(slot0.viewGO, "#scroll_prop/viewport/content").transform
	slot0._golock = gohelper.findChild(slot0.viewGO, "#scroll_prop/#go_lock")
	slot0._simagelockbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._gotabreddot1 = gohelper.findChild(slot0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	slot0._txtrefreshTime = gohelper.findChildText(slot0.viewGO, "#txt_refreshTime")
	slot0._lineGo = gohelper.findChild(slot0.viewGO, "line")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0.openduration = 0.6
	slot0.closeduration = 0.3
	slot0.moveduration = 0.3
	slot0.rootHeight = 397
	slot0._csPixel = nil
	slot0._categoryItemContainer = {}
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0, slot1)
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()
	slot0.jumpGoodsId = slot0.viewContainer:getJumpGoodsId()
	slot0._csView = slot0.viewContainer._ScrollViewRoomStore
	slot0._csScroll = slot0._csView:getCsScroll()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.SaveVerticalScrollPixel, slot0._savecsPixel, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.OpenRoomStoreNode, slot0.changeContentPosY, slot0)

	slot0._scrollprop.verticalNormalizedPosition = 1
end

function slot0.onClose(slot0)
	if slot0.delaycallBack then
		TaskDispatcher.cancelTask(slot0.delaycallBack, slot0)
	end

	TaskDispatcher.cancelTask(slot0.jumpClickChildGoods, slot0, slot0.openduration)
	slot0:removeEventCb(StoreController.instance, StoreEvent.SaveVerticalScrollPixel, slot0._savecsPixel, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.OpenRoomStoreNode, slot0.changeContentPosY, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot0._categoryItemContainer[slot4].btn:RemoveClickListener()
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

function slot0._savecsPixel(slot0)
	if slot0._csScroll then
		slot0._csPixel = slot0._csScroll.VerticalScrollPixel
	end
end

function slot0._updateInfo(slot0, slot1)
	slot0:_refreshGoods(false, slot1)
	slot0:_refreshRightTop()

	if slot0._csScroll:GetRenderCellRect(1, -1) then
		slot0.firstItemOffsetY = slot0:calculateFirstItemOffsetY(recthelper.getHeight(slot2))
	else
		return
	end

	if not slot1 then
		if not slot0.jumpGoodsId then
			slot0:changeContentPosY({
				index = 1,
				isFirstOpen = true,
				state = true,
				delay = true,
				itemHeight = slot0.rootHeight
			})
		else
			slot0:changeContentPosY({
				isFirstOpen = false,
				state = true,
				delay = true,
				index = slot0:_getRootIndexById(slot0.jumpGoodsId),
				itemHeight = slot0.rootHeight
			})

			slot0.jumpGoodsId = nil
		end
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
	slot2.go_reddotNormalType = gohelper.findChild(slot2.go, "#go_tabreddot1/type1")
	slot2.go_reddotNewType = gohelper.findChild(slot2.go, "#go_tabreddot1/type5")
	slot2.go_reddotActType = gohelper.findChild(slot2.go, "#go_tabreddot1/type9")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_line = gohelper.findChild(slot2.go, "#go_line")
	slot2.btn = gohelper.getClickWithAudio(slot2.go, AudioEnum.UI.play_ui_bank_open)
	slot2.tabId = 0

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		if slot0.tabId == StoreEnum.SubRoomOld then
			StoreModel.instance:setNewRedDotKey(slot0.tabId)
		end

		uv0:_refreshTabs(slot1)

		uv0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(slot1)
	end, slot2)
	table.insert(slot0._categoryItemContainer, slot2)
	gohelper.setActive(slot2.go_childItem, false)

	return slot2
end

function slot0._refreshTabs(slot0, slot1, slot2)
	slot3 = slot0._selectSecondTabId
	slot4 = slot0._selectThirdTabId
	slot0._selectSecondTabId = 0
	slot0._selectThirdTabId = 0
	slot0.openUpdate = slot2
	slot0._scrollprop.verticalNormalizedPosition = 1

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot5 = nil
	slot5, slot0._selectSecondTabId, slot0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(slot1)

	slot0:_refreshRightTop()

	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot6 > 0 then
		for slot10 = 1, #slot6 do
			slot0:_refreshSecondTabs(slot10, slot6[slot10])
			gohelper.setActive(slot0._categoryItemContainer[slot10].go, true)
		end

		gohelper.setActive(slot0._categoryItemContainer[#slot6].go_line, false)

		for slot10 = #slot6 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot10].go, false)
		end

		gohelper.setActive(slot0._lineGo, true)
	else
		for slot10 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot10].go, false)
		end

		gohelper.setActive(slot0._lineGo, false)
	end

	slot0:_onRefreshRedDot()

	if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
		return
	end

	slot7 = slot0._selectSecondTabId == StoreEnum.StoreId.CritterStore

	gohelper.setActive(slot0._gocritter.gameObject, slot7)
	gohelper.setActive(slot0._scrollprop.gameObject, not slot7)

	if slot7 then
		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 5, 1)
	end

	slot0:_refreshGoods(true)
end

function slot0._refreshRightTop(slot0)
	slot2 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
	slot3 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

	if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot1.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot1.showCost))
	elseif slot2 and not string.nilorempty(slot2.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot2.showCost))
	elseif slot3 and not string.nilorempty(slot3.showCost) then
		slot0.viewContainer:setCurrencyByParams(slot0:packShowCostParam(slot3.showCost))
	else
		slot0.viewContainer:setCurrencyByParams(nil)
	end
end

function slot0._refreshGoods(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		slot3 = slot2
	end

	slot0.storeId = 0
	slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and slot4.storeId or 0

	if slot0.storeId == 0 then
		slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId) and slot5.storeId or 0
	end

	if slot0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	elseif slot0.storeId == StoreEnum.StoreId.CritterStore then
		gohelper.setActive(slot0._goempty, false)

		if slot1 then
			slot0.viewContainer:playCritterStoreAnimation()
		end
	else
		if StoreModel.instance:getStoreMO(slot0.storeId) then
			if not next(slot5:getGoodsList(true)) then
				gohelper.setActive(slot0._goempty, true)
			else
				gohelper.setActive(slot0._goempty, false)
			end

			slot0.rootGoodsList = {}
			slot7 = {}

			for slot11, slot12 in pairs(slot6) do
				slot13 = {}

				if slot12:getOffTab() then
					slot13 = GameUtil.splitString2(slot12:getOffTab())
					slot12.goodscn = slot13[1][2]
					slot12.goodsen = slot13[1][3]

					if slot0.jumpGoodsId then
						slot12.isjump = true
					end
				end

				if not string.nilorempty(slot12.config.nameEn) then
					slot12.update = slot1

					table.insert(slot0.rootGoodsList, slot12)
				elseif slot12:checkJumpGoodCanOpen() then
					table.insert(slot7, slot12)
				end
			end

			for slot11, slot12 in pairs(slot0.rootGoodsList) do
				for slot16, slot17 in pairs(slot7) do
					if slot17.goodsen == slot12.config.nameEn then
						if slot12.children == nil then
							slot12.children = {}

							table.insert(slot12.children, slot17)
						else
							if slot3 and slot17.goodsId == slot3 then
								slot12.isExpand = true
							end

							if not tabletool.indexOf(slot12.children, slot17) then
								table.insert(slot12.children, slot17)
							end
						end
					end
				end
			end

			for slot11, slot12 in ipairs(slot0.rootGoodsList) do
				if slot12.children == nil then
					table.remove(slot0.rootGoodsList, slot11)
				end
			end

			StoreRoomGoodsItemListModel.instance:setMOList(slot0.rootGoodsList)

			if slot0._csPixel then
				slot0._csScroll.VerticalScrollPixel = slot0._csPixel
				slot0._csPixel = nil
			end
		end

		if slot1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				slot0.storeId
			})
		end
	end
end

function slot0.changeContentPosY(slot0, slot1)
	slot3 = slot1.state
	slot4 = slot1.itemHeight
	slot5 = slot1.delay
	slot6 = slot1.isFirstOpen

	if not slot1.index then
		return
	end

	if slot0.storeId == StoreEnum.StoreId.NewRoomStore then
		if StoreRoomGoodsItemListModel.instance:getRootCount() - 1 >= 2 and slot6 then
			return
		end
	elseif slot0.storeId == StoreEnum.StoreId.OldRoomStore and slot6 then
		return
	end

	slot0.openduration = Mathf.Ceil(#StoreRoomGoodsItemListModel.instance:getByIndex(slot2, 0).children / 4) * 0.2
	slot10 = slot0.moveduration * slot2

	function slot0.delaycallBack()
		if uv0 and uv1._csView then
			uv1._csView:expand(uv0, nil, uv1.openduration)

			if uv1.jumpClickChildGoodsId then
				TaskDispatcher.runDelay(uv1.jumpClickChildGoods, uv1, uv1.openduration)
			end
		end
	end

	slot11 = nil

	if slot3 then
		slot12 = slot0:calculateFirstItemOffsetY(slot4)
		slot11 = (not slot5 or function ()
			TaskDispatcher.runDelay(uv0.delaycallBack, uv0, uv1)
		end) and function ()
			uv0._csView:expand(uv1, nil, uv0.openduration)
		end

		if slot0.jumpGoodsId then
			TaskDispatcher.runDelay(slot0.delaycallBack, slot0, slot10)
		else
			slot0:checkOtherItemIsExpand(slot11)
		end

		if slot2 == 1 then
			ZProj.TweenHelper.DOLocalMoveY(slot0._trscontent, 0, slot0.moveduration)

			return
		end

		if slot0.firstItemOffsetY == nil then
			slot0.firstItemOffsetY = slot0:calculateFirstItemOffsetY(slot0.rootHeight)
		end

		ZProj.TweenHelper.DOLocalMoveY(slot0._trscontent, slot4 * (slot2 - 1) + slot0.firstItemOffsetY - slot12, slot5 and slot10 or slot0.moveduration)
	else
		slot0._csView:shrink(slot2, nil, slot0.closeduration)
	end
end

function slot0.jumpClickChildGoods(slot0)
	if not slot0.jumpClickChildGoodsId then
		return
	end

	StoreController.instance:dispatchEvent(StoreEvent.jumpClickRoomChildGoods, slot0.jumpClickChildGoodsId)

	slot0.jumpClickChildGoodsId = nil
end

function slot0.calculateFirstItemOffsetY(slot0, slot1)
	return (recthelper.getHeight(slot0._trsviewport) + 25 - slot1) / 2
end

function slot0.checkOtherItemIsExpand(slot0, slot1)
	slot3 = false

	for slot7 = 1, #StoreRoomGoodsItemListModel.instance:getInfoList() do
		if slot0._csView:isExpand(slot7) then
			slot0._csView:shrink(slot7, nil, 0.3, slot1, slot0)

			break
		end
	end

	if not slot3 then
		slot1()
	end
end

function slot0._getRootIndexById(slot0, slot1)
	if not slot0.rootGoodsList then
		return
	end

	slot3 = StoreConfig.instance:getGoodsConfig(slot1) and GameUtil.splitString2(slot2.product, true) or {}

	for slot7 = 1, #slot0.rootGoodsList do
		slot8 = false

		if slot0.rootGoodsList[slot7].goodsId == slot1 then
			slot8 = true
		elseif slot9:hasProduct(slot3[1][1], slot3[1][2]) then
			slot8 = true
			slot0.jumpClickChildGoodsId = slot1
		end

		if slot8 then
			return slot7
		end
	end
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		slot6, slot7 = StoreModel.instance:isTabFirstRedDotShow(slot5.tabId)
		slot8 = false

		if slot5.tabId == StoreEnum.SubRoomOld then
			slot8 = StoreModel.instance:checkShowNewRedDot(slot5.tabId)
		end

		if slot8 then
			slot6 = true
		end

		gohelper.setActive(slot5.go_reddot, slot6)
		gohelper.setActive(slot5.go_reddotNewType, slot8)
		gohelper.setActive(slot5.go_reddotNormalType, not slot8 and not slot7)
		gohelper.setActive(slot5.go_reddotActType, not slot8 and slot7)
	end
end

function slot0.packShowCostParam(slot0, slot1)
	slot2 = {}

	for slot7 = #string.split(slot1, "#"), 1, -1 do
		if ItemModel.instance:getItemCount(tonumber(slot3[slot7])) > 0 and not CurrencyModel.instance:getCurrency(slot8) then
			table.insert(slot2, {
				isCurrencySprite = true,
				id = slot8,
				type = MaterialEnum.MaterialType.Item
			})
		elseif CurrencyModel.instance:getCurrency(slot8) then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

return slot0
