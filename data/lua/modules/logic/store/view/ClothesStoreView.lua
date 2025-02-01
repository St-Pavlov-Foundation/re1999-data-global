module("modules.logic.store.view.ClothesStoreView", package.seeall)

slot0 = class("ClothesStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollprop.gameObject)
	slot0._godeduction = gohelper.findChild(slot0.viewGO, "#go_deduction")
	slot0._txtdeduction = gohelper.findChildTextMesh(slot0.viewGO, "#go_deduction/#txt_deadTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, slot0._isSkinEmpty, slot0)
	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0._updateItemList, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._scrollprop:AddOnValueChanged(slot0._onDragging, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, slot0._isSkinEmpty, slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._updateItemList, slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._scrollprop:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostorecategoryitem, false)

	slot0._categoryItemContainer = {}

	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))
	gohelper.setActive(slot0._goempty, false)
end

function slot0._isSkinEmpty(slot0, slot1)
	gohelper.setActive(slot0._goempty, slot1)
end

function slot0._payFinished(slot0)
	if ViewMgr.instance:isOpen(ViewName.StoreSkinPreviewView) then
		ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	end

	slot0:_refreshGoods(true)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListBegin)
end

function slot0._onDragging(slot0)
	StoreController.instance:dispatchEvent(StoreEvent.DraggingSkinList)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	StoreController.instance:dispatchEvent(StoreEvent.DragSkinListEnd)
end

function slot0._refreshTabs(slot0, slot1, slot2)
	slot3 = slot0._selectSecondTabId
	slot4 = slot0._selectThirdTabId
	slot0._selectSecondTabId = 0
	slot0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot5 = nil
	slot5, slot0._selectSecondTabId, slot0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(slot1)
	slot7 = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId)
	slot8 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())
	slot9 = {}

	if StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and not string.nilorempty(slot6.showCost) then
		slot9 = string.splitToNumber(slot6.showCost, "#")
	elseif slot7 and not string.nilorempty(slot7.showCost) then
		slot9 = string.splitToNumber(slot7.showCost, "#")
	elseif slot8 and not string.nilorempty(slot8.showCost) then
		slot9 = string.splitToNumber(slot8.showCost, "#")
	end

	if ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)[1] then
		table.insert(slot9, {
			isCurrencySprite = true,
			type = MaterialEnum.MaterialType.Item,
			id = slot10[1].id
		})

		slot11 = 0

		if ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot10[1].id) and not string.nilorempty(slot12.expireTime) and math.floor(TimeUtil.stringToTimestamp(slot12.expireTime) - ServerTime.now()) >= 0 and slot14 <= 259200 then
			slot11 = math.max(math.floor(slot14 / 60 / 60), 1)
		end

		if slot11 > 0 then
			gohelper.setActive(slot0._godeduction, true)

			slot0._txtdeduction.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_deduction_item_deadtime"), tostring(slot11))
		else
			gohelper.setActive(slot0._godeduction, false)
		end
	else
		gohelper.setActive(slot0._godeduction, false)
	end

	slot0.viewContainer:setCurrencyByParams(slot9)

	if not slot2 and slot3 == slot0._selectSecondTabId and slot4 == slot0._selectThirdTabId then
		return
	end

	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot11 > 0 then
		for slot15 = 1, #slot11 do
			slot0:_refreshSecondTabs(slot15, slot11[slot15])
			gohelper.setActive(slot0._categoryItemContainer[slot15].go, true)
		end

		for slot15 = #slot11 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot15].go, false)
		end
	else
		for slot15 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot15].go, false)
		end
	end

	slot0:_onRefreshRedDot()
	slot0:_refreshGoods(true)

	slot0._scrollprop.verticalNormalizedPosition = 1
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
	slot3 = slot0._categoryItemContainer[slot1] or slot0:initCategoryItemTable(slot1)
	slot3.tabId = slot2.id
	slot3.txt_itemcn1.text = slot2.name
	slot3.txt_itemcn2.text = slot2.name
	slot3.txt_itemen1.text = slot2.nameEn
	slot3.txt_itemen2.text = slot2.nameEn
	slot4 = slot0._selectSecondTabId == slot2.id

	gohelper.setActive(slot3.go_unselected, not slot4)
	gohelper.setActive(slot3.go_selected, slot4)
	gohelper.setActive(slot3.go_line, slot4 and #StoreModel.instance:getThirdTabs(slot2.id, true, true) > 0)

	if slot4 and slot5 and #slot5 > 0 then
		for slot9 = 1, #slot5 do
			slot0:_refreshThirdTabs(slot3, slot9, slot5[slot9])
			gohelper.setActive(slot3.childItemContainer[slot9].go, true)
		end

		for slot9 = #slot5 + 1, #slot3.childItemContainer do
			gohelper.setActive(slot3.childItemContainer[slot9].go, false)
		end
	else
		for slot9 = 1, #slot3.childItemContainer do
			gohelper.setActive(slot3.childItemContainer[slot9].go, false)
		end
	end
end

function slot0.initCategoryItemTable(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gostorecategoryitem, "item" .. slot1)
	slot2.go_unselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.go_selected = gohelper.findChild(slot2.go, "go_selected")
	slot2.go_line = gohelper.findChild(slot2.go, "go_line")
	slot2.go_reddot = gohelper.findChild(slot2.go, "go_selected/txt_itemcn2/go_catereddot")
	slot2.go_unselectreddot = gohelper.findChild(slot2.go, "go_unselected/txt_itemcn1/go_unselectreddot")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_childcategory = gohelper.findChild(slot2.go, "go_childcategory")
	slot2.go_childItem = gohelper.findChild(slot2.go, "go_childcategory/go_childitem")
	slot2.childItemContainer = {}
	slot2.btnGO = gohelper.findChild(slot2.go, "clickArea")
	slot2.btn = gohelper.getClick(slot2.btnGO)
	slot2.tabId = 0

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		uv0:_refreshTabs(slot1)
		StoreController.instance:statSwitchStore(slot1)
	end, slot2)
	table.insert(slot0._categoryItemContainer, slot2)
	gohelper.setActive(slot2.go_childItem, false)

	return slot2
end

function slot0._refreshThirdTabs(slot0, slot1, slot2, slot3)
	if not slot1.childItemContainer[slot2] then
		slot4 = slot0:getUserDataTb_()
		slot4.go = gohelper.cloneInPlace(slot1.go_childItem, "item" .. slot2)
		slot4.go_unselected = gohelper.findChild(slot4.go, "go_unselected")
		slot4.go_selected = gohelper.findChild(slot4.go, "go_selected")
		slot4.go_subreddot1 = gohelper.findChild(slot4.go, "go_unselected/txt_itemcn1/go_subcatereddot")
		slot4.go_subreddot2 = gohelper.findChild(slot4.go, "go_selected/txt_itemcn2/go_subcatereddot")
		slot4.txt_itemcn1 = gohelper.findChildText(slot4.go, "go_unselected/txt_itemcn1")
		slot4.txt_itemen1 = gohelper.findChildText(slot4.go, "go_unselected/txt_itemen1")
		slot4.txt_itemcn2 = gohelper.findChildText(slot4.go, "go_selected/txt_itemcn2")
		slot4.txt_itemen2 = gohelper.findChildText(slot4.go, "go_selected/txt_itemen2")
		slot4.btnGO = gohelper.findChild(slot4.go, "clickArea")
		slot4.btn = gohelper.getClick(slot4.btnGO)
		slot4.tabId = 0

		slot4.btn:AddClickListener(function (slot0)
			slot1 = slot0.tabId

			uv0:_refreshTabs(slot1, nil, true)
			StoreController.instance:statSwitchStore(slot1)
		end, slot4)
		table.insert(slot1.childItemContainer, slot4)
	end

	slot4.tabId = slot3.id
	slot4.txt_itemcn1.text = slot3.name
	slot4.txt_itemcn2.text = slot3.name
	slot4.txt_itemen1.text = slot3.nameEn
	slot4.txt_itemen2.text = slot3.nameEn
	slot5 = slot0._selectThirdTabId == slot3.id

	gohelper.setActive(slot4.go_unselected, not slot5)
	gohelper.setActive(slot4.go_selected, slot5)
end

function slot0._refreshGoods(slot0, slot1)
	if slot1 then
		slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectThirdTabId) and slot2.storeId or 0

		if slot0.storeId == 0 then
			slot0.storeId = StoreConfig.instance:getTabConfig(slot0._selectSecondTabId) and slot3.storeId or 0
		end

		StoreRpc.instance:sendGetStoreInfosRequest({
			slot0.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest()
	end
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		gohelper.setActive(slot5.go_reddot, StoreModel.instance:isTabFirstRedDotShow(slot5.tabId))

		slot8 = StoreModel.instance
		slot9 = slot8
		slot10 = slot5.tabId

		gohelper.setActive(slot5.go_unselectreddot, slot8.isTabFirstRedDotShow(slot9, slot10))

		for slot9, slot10 in pairs(slot5.childItemContainer) do
			gohelper.setActive(slot10.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(slot10.tabId))
			gohelper.setActive(slot10.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(slot10.tabId))
		end
	end
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)

	if slot0.viewContainer:getJumpGoodsId() then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(slot2))
		})
	end

	slot0._scrollprop.horizontalNormalizedPosition = 0
end

function slot0._updateItemList(slot0)
	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
end

function slot0._updateInfo(slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.CheckSkinViewEmpty, slot0._isSkinEmpty, slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._updateItemList, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId())

	if slot0.viewContainer:getJumpGoodsId() then
		ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
			goodsMO = StoreModel.instance:getGoodsMO(tonumber(slot2))
		})
	end
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItemContainer and #slot0._categoryItemContainer > 0 then
		for slot4 = 1, #slot0._categoryItemContainer do
			slot5 = slot0._categoryItemContainer[slot4]

			slot5.btn:RemoveClickListener()

			if slot5.childItemContainer and #slot5.childItemContainer > 0 then
				for slot9 = 1, #slot5.childItemContainer do
					slot5.childItemContainer[slot9].btn:RemoveClickListener()
				end
			end
		end
	end

	slot0._simagebg:UnLoadImage()
end

return slot0
