module("modules.logic.activity.view.ActivityStarLightSignPart1View_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPart1View_1_3", ActivityStarLightSignViewBase_1_3)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle1"))
	slot0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlightfullbg1"))
end

return slot0
