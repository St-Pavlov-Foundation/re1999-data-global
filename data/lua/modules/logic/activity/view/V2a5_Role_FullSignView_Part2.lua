module("modules.logic.activity.view.V2a5_Role_FullSignView_Part2", package.seeall)

local var_0_0 = class("V2a5_Role_FullSignView_Part2", V2a5_Role_FullSignView)

function var_0_0._editableInitView(arg_1_0)
	GameUtil.loadSImage(arg_1_0._simageFullBG, ResUrl.getV2a5SignSingleBg("v2a5_sign_fullbg2"))
	GameUtil.loadSImage(arg_1_0._simageTitle, ResUrl.getV2a5SignSingleBgLang("v2a5_sign_titie_2"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, true)
end

return var_0_0
