module("modules.logic.activity.view.V2a3_Role_FullSignView_Part2", package.seeall)

local var_0_0 = class("V2a3_Role_FullSignView_Part2", V2a3_Role_FullSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageFullBG:LoadImage(ResUrl.getV2a3SignSingleBg("v2a3_sign_fullbg2"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a3SignSingleBgLang("v2a3_sign_titie_2"))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect1")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "Root/vx_effect2")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, true)
end

return var_0_0
