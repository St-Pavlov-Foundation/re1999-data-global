module("modules.logic.activity.view.V1a5_Role_PanelSignView_Part1", package.seeall)

local var_0_0 = class("V1a5_Role_PanelSignView_Part1", V1a5_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_kerandian_title"))
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_kerandian_sign_panelbg"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, true)
	gohelper.setActive(var_1_1, false)
end

return var_0_0
