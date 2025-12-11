module("modules.logic.survival.view.map.SurvivalLoadingView", package.seeall)

local var_0_0 = class("SurvivalLoadingView", BaseView)

function var_0_0.onOpen(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_loading)
end

function var_0_0._onOpenView(arg_2_0, arg_2_1)
	return
end

function var_0_0.onClose(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.stop_ui_fuleyuan_tansuo_loading)
end

return var_0_0
