module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_LevelViewContainer", package.seeall)

local var_0_0 = class("GM_V3a1_GaoSiNiao_LevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		GM_V3a1_GaoSiNiao_LevelView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

function var_0_0.addEvents(arg_3_0)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, arg_3_0._gm_showAllTabIdUpdate, arg_3_0)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, arg_3_0._gm_enableEditModeOnSelect, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, arg_4_0._gm_showAllTabIdUpdate, arg_4_0)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, arg_4_0._gm_enableEditModeOnSelect, arg_4_0)
end

return var_0_0
