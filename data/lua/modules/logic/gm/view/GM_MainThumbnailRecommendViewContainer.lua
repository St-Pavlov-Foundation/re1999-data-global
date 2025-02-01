module("modules.logic.gm.view.GM_MainThumbnailRecommendViewContainer", package.seeall)

slot0 = class("GM_MainThumbnailRecommendViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		GM_MainThumbnailRecommendView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addEvents(slot0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, slot0._gm_showAllBannerUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, slot0._gm_stopBannerLoopAnimUpdate, slot0)
end

function slot0.removeEvents(slot0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, slot0._gm_showAllBannerUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, slot0._gm_showAllTabIdUpdate, slot0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, slot0._gm_stopBannerLoopAnimUpdate, slot0)
end

return slot0
