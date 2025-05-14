module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_Part2", package.seeall)

local var_0_0 = class("V1a6_Role_PanelSignView_Part2", V1a6_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageTitle:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_sign_logo"))
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_getian_sign_panelbg"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, true)
end

return var_0_0
