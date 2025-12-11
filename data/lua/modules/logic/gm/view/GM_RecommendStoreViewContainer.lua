module("modules.logic.gm.view.GM_RecommendStoreViewContainer", package.seeall)

local var_0_0 = class("GM_RecommendStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_RecommendStoreView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addEvents(arg_3_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, arg_3_0._gm_showAllBannerUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, arg_3_0._gm_showAllTabIdUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, arg_3_0._gm_stopBannerLoopAnimUpdate, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, arg_4_0._gm_showAllBannerUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, arg_4_0._gm_showAllTabIdUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, arg_4_0._gm_stopBannerLoopAnimUpdate, arg_4_0)
end

return var_0_0
