module("modules.logic.activity.view.V2a1_Role_PanelSignView_Part2", package.seeall)

local var_0_0 = class("V2a1_Role_PanelSignView_Part2", V2a1_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV2a1SignSingleBg("v2a1_sign_panelbg2"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a1SignSingleBgLang("v2a1_sign_title2"))
end

return var_0_0
