module("modules.logic.activity.view.V2a0_Role_FullSignView_Part1", package.seeall)

local var_0_0 = class("V2a0_Role_FullSignView_Part1", V2a0_Role_FullSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageFullBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_fullbg2"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title1"))
end

return var_0_0
