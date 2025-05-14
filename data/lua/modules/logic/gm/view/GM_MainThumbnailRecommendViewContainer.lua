module("modules.logic.gm.view.GM_MainThumbnailRecommendViewContainer", package.seeall)

local var_0_0 = class("GM_MainThumbnailRecommendViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_MainThumbnailRecommendView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addEvents(arg_3_0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, arg_3_0._gm_showAllBannerUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, arg_3_0._gm_showAllTabIdUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, arg_3_0._gm_stopBannerLoopAnimUpdate, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, arg_4_0._gm_showAllBannerUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, arg_4_0._gm_showAllTabIdUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, arg_4_0._gm_stopBannerLoopAnimUpdate, arg_4_0)
end

return var_0_0
