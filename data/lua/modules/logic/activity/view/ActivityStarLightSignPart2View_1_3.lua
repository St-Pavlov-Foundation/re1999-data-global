module("modules.logic.activity.view.ActivityStarLightSignPart2View_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignPart2View_1_3", ActivityStarLightSignViewBase_1_3)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle2"))
	arg_1_0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlightfullbg2"))
end

return var_0_0
