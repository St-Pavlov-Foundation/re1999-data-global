module("modules.logic.activity.view.V2a0_Role_PanelSignView_Part2", package.seeall)

local var_0_0 = class("V2a0_Role_PanelSignView_Part2", V2a0_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_panelbg1"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title2"))
end

return var_0_0
