module("modules.logic.activity.view.V2a4_Role_PanelSignView_Part1", package.seeall)

local var_0_0 = class("V2a4_Role_PanelSignView_Part1", V2a4_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	GameUtil.loadSImage(arg_1_0._simagePanelBG, ResUrl.getV2a4SignSingleBg("v2a4_sign_panelbg1"))

	local var_1_0 = ResUrl.getV2a4SignSingleBgLang("v2a4_sign_title_1")

	GameUtil.loadSImage(arg_1_0._simageTitle, var_1_0)
	GameUtil.loadSImage(arg_1_0._simageTitle_glow, var_1_0)

	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_2 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_1, true)
	gohelper.setActive(var_1_2, false)
end

return var_0_0
