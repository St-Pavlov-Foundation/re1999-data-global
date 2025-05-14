module("modules.logic.activity.view.V2a1_Role_PanelSignView_Part1", package.seeall)

local var_0_0 = class("V2a1_Role_PanelSignView_Part1", V2a1_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV2a1SignSingleBg("v2a1_sign_panelbg1"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getV2a1SignSingleBgLang("v2a1_sign_title1"))
end

return var_0_0
