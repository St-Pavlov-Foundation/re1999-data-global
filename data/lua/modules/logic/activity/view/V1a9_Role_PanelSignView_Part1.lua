module("modules.logic.activity.view.V1a9_Role_PanelSignView_Part1", package.seeall)

local var_0_0 = class("V1a9_Role_PanelSignView_Part1", V1a9_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_sign_panelbg1"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, true)
	gohelper.setActive(var_1_1, false)
end

return var_0_0
