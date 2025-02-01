module("modules.logic.gm.view.GM_NormalStoreViewContainer", package.seeall)

slot0 = class("GM_NormalStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_NormalStoreView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, slot0._gm_showAllGoodsIdUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, slot0._gm_showAllGoodsIdUpdate, slot0)
end

return slot0
