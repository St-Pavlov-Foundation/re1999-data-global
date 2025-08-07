module("modules.logic.mainuiswitch.view.MainUISwitchInfoDisplayView", package.seeall)

local var_0_0 = class("MainUISwitchInfoDisplayView", MainSceneSwitchInfoDisplayView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
	gohelper.setActive(arg_1_0._gobg1, false)
	gohelper.setActive(arg_1_0._gobg2, false)
	gohelper.setActive(arg_1_0._rawImage.gameObject, false)
end

function var_0_0._onShowSceneInfo(arg_2_0, arg_2_1)
	arg_2_0._sceneId = arg_2_1
end

return var_0_0
