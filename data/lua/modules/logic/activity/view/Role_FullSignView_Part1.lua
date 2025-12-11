module("modules.logic.activity.view.Role_FullSignView_Part1", package.seeall)

local var_0_0 = class("Role_FullSignView_Part1", Role_FullSignView)

function var_0_0._editableInitView(arg_1_0)
	GameUtil.loadSImage(arg_1_0._simageFullBG, ResUrl.getRoleSignSingleBg("role_sign_fullbg1"))
	GameUtil.loadSImage(arg_1_0._simageTitle, ResUrl.getRoleSignSingleBgLang("role_sign_title_1"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, true)
	gohelper.setActive(var_1_1, false)
end

return var_0_0
