module("modules.logic.activity.view.Role_PanelSignView_Part2", package.seeall)

local var_0_0 = class("Role_PanelSignView_Part2", Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	GameUtil.loadSImage(arg_1_0._simagePanelBG, ResUrl.getRoleSignSingleBg("role_sign_panelbg2"))
	GameUtil.loadSImage(arg_1_0._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_2"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, true)
end

return var_0_0
