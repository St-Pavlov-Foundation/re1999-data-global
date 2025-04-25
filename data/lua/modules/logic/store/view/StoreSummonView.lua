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

	gohelper.setActive(slot0._txtrefreshTime.gameObject, false)
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
	slot0.storeId = StoreEnum.StoreId.LimitStore

	slot0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:AddClickListener(slot0._onLockClick, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._updateInfo, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0._lockClick:RemoveClickListener()
end

function slot0.refreshRemainTime(slot0)
	if StoreHelper.getRemainExpireTime(StoreConfig.instance:getTabConfig(slot0.storeId)) and slot2 > 0 then
		slot0._txtrefreshTime.text = string.format(luaLang("summon_limit_shop_remaintime"), SummonModel.formatRemainTime(slot2))
	else
		slot0._txtrefreshTime.text = ""
	end
end

function slot0.refreshLockStatus(slot0)
	if slot0._selectThirdTabId > 0 then
		slot0._isLock = StoreModel.instance:isStoreTabLock(slot0.storeId)

		if slot0._isLock then
			slot0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(StoreConfig.instance:getStoreConfig(slot0.storeId).needClearStore).name)
		end

		gohelper.setActive(slot0._golock, slot0._isLock)
	else
		gohelper.setActive(slot0._golock, false)
	end
end

function slot0._refreshSecondTabs(slot0, slot1, slot2)
end

function slot0._refreshGoods(slot0)
end

function slot0._onLockClick(slot0)
	if slot0._isLock then
		GameFacade.showToast(ToastEnum.NormalStoreIsLock, StoreConfig.instance:getTabConfig(slot0.storeId).name)
	end
end

function slot0._updateInfo(slot0)
end

function slot0._onRefreshRedDot(slot0)
	for slot4, slot5 in pairs(slot0._categoryItemContainer) do
		gohelper.setActive(slot5.go_reddot, StoreModel.instance:isTabFirstRedDotShow(slot5.tabId))
	end
end

function slot0.onUpdateParam(slot0)
end

return slot0
