module("modules.logic.store.view.ChargeStoreView", package.seeall)

slot0 = class("ChargeStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostorecategoryitem, false)

	slot0._categoryItemContainer = {}

	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	slot0._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	slot0._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))
end

function slot0._refreshTabs(slot0, slot1, slot2, slot3)
	slot4 = slot0._selectSecondTabId
	slot5 = slot0._selectThirdTabId
	slot0._selectSecondTabId = 0
	slot0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot6 = nil
	slot6, slot0._selectSecondTabId, slot0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(slot1)
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

	if not slot2 and slot4 == slot0._selectSecondTabId and slot5 == slot0._selectThirdTabId then
		return
	end

	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot10 > 0 then
		for slot14 = 1, #slot10 do
			slot0:_refreshSecondTabs(slot14, slot10[slot14])
			gohelper.setActive(slot0._categoryItemContainer[slot14].go, true)
		end

		for slot14 = #slot10 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot14].go, false)
		end
	else
		for slot14 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot14].go, false)
		end
	end

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
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	ChargeRpc.instance:sendGetChargeInfoRequest()
end

function slot0._updateInfo(slot0)
	slot0:_refreshGoods(false)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId())
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
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
end

return slot0
