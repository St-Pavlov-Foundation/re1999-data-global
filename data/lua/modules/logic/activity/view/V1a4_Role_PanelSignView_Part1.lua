module("modules.logic.activity.view.V1a4_Role_PanelSignView_Part1", package.seeall)

local var_0_0 = class("V1a4_Role_PanelSignView_Part1", V1a4_Role_PanelSignView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageTitle:LoadImage(ResUrl.getV1a4SignSingleBgLang("v1a4_sign_paneltitle1"))
	arg_1_0._simagePanelBG:LoadImage(ResUrl.getV1a4SignSingleBg("v1a4_role37_sign_panelbg"))
end

return var_0_0
