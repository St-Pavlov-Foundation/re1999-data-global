module("modules.logic.store.view.ChargeStoreView", package.seeall)

slot0 = class("ChargeStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon")
	slot0._gostorecategoryitem = gohelper.findChild(slot0.viewGO, "scroll_category/viewport/categorycontent/#go_storecategoryitem")
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

function slot0._refreshAllSecondTabs(slot0)
	if StoreModel.instance:getSecondTabs(slot0._selectFirstTabId, true, true) and #slot1 > 0 then
		for slot5 = 1, #slot1 do
			slot0:_refreshSecondTabs(slot5, slot1[slot5])
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, true)
		end

		for slot5 = #slot1 + 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end
	else
		for slot5 = 1, #slot0._categoryItemContainer do
			gohelper.setActive(slot0._categoryItemContainer[slot5].go, false)
		end
	end
end

function slot0._refreshTabs(slot0, slot1, slot2, slot3)
	slot4 = slot0._selectSecondTabId
	slot0._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(slot1) then
		slot1 = slot0.viewContainer:getSelectFirstTabId()
	end

	slot5 = nil
	slot5, slot0._selectSecondTabId, slot5 = StoreModel.instance:jumpTabIdToSelectTabId(slot1)
	slot7 = StoreConfig.instance:getTabConfig(slot0.viewContainer:getSelectFirstTabId())

	if StoreConfig.instance:getTabConfig(slot0._selectSecondTabId) and not string.nilorempty(slot6.showCost) then
		slot0.viewContainer:setCurrencyType(slot6.showCost)
	elseif slot7 and not string.nilorempty(slot7.showCost) then
		slot0.viewContainer:setCurrencyType(slot7.showCost)
	else
		slot0.viewContainer:setCurrencyType(nil)
	end

	if not slot2 and slot4 == slot0._selectSecondTabId then
		return
	end

	slot0:_refreshAllSecondTabs()
	StoreController.instance:readTab(slot1)
	slot0:_onRefreshRedDot()

	slot0._resetScrollPos = true

	slot0:_refreshGood()
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		gohelper.setActive(slot5.go_reddot, StoreModel.instance:isTabFirstRedDotShow(slot5.tabId))
	end
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
end

function slot0.initCategoryItemTable(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gostorecategoryitem, "item" .. slot1)
	slot2.go_unselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.go_selected = gohelper.findChild(slot2.go, "go_selected")
	slot2.go_line = gohelper.findChild(slot2.go, "go_line")
	slot2.go_reddot = gohelper.findChild(slot2.go, "#go_tabreddot1")
	slot2.txt_itemcn1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txt_itemen1 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.txt_itemcn2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txt_itemen2 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.go_childcategory = gohelper.findChild(slot2.go, "go_childcategory")
	slot2.go_childItem = gohelper.findChild(slot2.go, "go_childcategory/go_childitem")
	slot2.childItemContainer = {}
	slot2.btnGO = gohelper.findChild(slot2.go, "clickArea")
	slot2.btn = gohelper.getClickWithAudio(slot2.go, AudioEnum.UI.play_ui_bank_open)
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

function slot0._refreshGood(slot0)
	StoreModel.instance:setCurChargeStoreId(slot0._selectSecondTabId)
	StoreChargeGoodsItemListModel.instance:setMOList(StoreModel.instance:getChargeGoods(), slot0._selectSecondTabId)
end

function slot0.onOpen(slot0)
	slot0._selectFirstTabId = slot0.viewContainer:getSelectFirstTabId()

	slot0:_refreshTabs(slot0.viewContainer:getJumpTabId(), true)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(PayController.instance, PayEvent.PayInfoChanged, slot0._updateInfo, slot0)
	ChargeRpc.instance:sendGetChargeInfoRequest()
end

function slot0._updateInfo(slot0)
	slot0:_refreshGood()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.PayInfoChanged, slot0._updateInfo, slot0)
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
