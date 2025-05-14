module("modules.logic.gm.view.GM_NormalStoreViewContainer", package.seeall)

local var_0_0 = class("GM_NormalStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_NormalStoreView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addEvents(arg_3_0)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, arg_3_0._gm_showAllTabIdUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, arg_3_0._gm_showAllGoodsIdUpdate, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, arg_4_0._gm_showAllTabIdUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, arg_4_0._gm_showAllGoodsIdUpdate, arg_4_0)
end

return var_0_0
