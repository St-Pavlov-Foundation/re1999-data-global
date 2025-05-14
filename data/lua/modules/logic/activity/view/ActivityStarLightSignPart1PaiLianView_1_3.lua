module("modules.logic.activity.view.ActivityStarLightSignPart1PaiLianView_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignPart1PaiLianView_1_3", ActivityStarLightSignPaiLianViewBase_1_3)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._actId = ActivityEnum.Activity.StarLightSignPart1_1_3

	arg_1_0._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlighthalfbg1"))
	arg_1_0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle1"))
end

return var_0_0
