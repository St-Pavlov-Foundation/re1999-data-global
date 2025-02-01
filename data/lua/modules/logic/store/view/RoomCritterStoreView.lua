module("modules.logic.store.view.RoomCritterStoreView", package.seeall)

slot0 = class("RoomCritterStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrolltab = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tab")
	slot0._gotab = gohelper.findChild(slot0.viewGO, "#scroll_tab/Viewport/Content/#go_tab")
	slot0._scrollgoods = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_goods")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0._updateInfo(slot0)
	StoreCritterGoodsItemListModel.instance:setMOList(StoreEnum.StoreId.CritterStore)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gotab, false)
	gohelper.setActive(slot0._scrolltab.gameObject, false)
	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.CritterStore
	}, slot0._updateInfo, slot0)
end

function slot0._getTabItem(slot0, slot1)
	if not slot0._tabItems then
		slot0._tabItems = slot0:getUserDataTb_()
	end

	if not slot0._tabItems[slot1] then
		slot2 = {
			goSelect = gohelper.findChild(slot3, "bg/select"),
			btn = gohelper.findChildButtonWithAudio(slot3, "bg/btn")
		}
		slot3 = gohelper.cloneInPlace(slot0._gotab)

		slot2.btn:AddClickListener(slot0._onClickTab, slot0, slot1)

		slot2.txt = gohelper.findChildText(slot3, "txt")
		slot2.go = slot3
	end

	slot0._tabItems[slot1] = slot2

	return slot2
end

function slot0._onClickTab(slot0, slot1)
	if slot0._selectTabIndex == slot1 then
		return
	end

	slot0._selectTabIndex = slot1

	slot0:_refreshSelectTab()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._tabItems then
		for slot4 = 1, #slot0._tabItems do
			slot0._tabItems[slot4].btn:RemoveClickListener()
		end
	end
end

return slot0
