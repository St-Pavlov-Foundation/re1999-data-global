module("modules.logic.activity.view.ActivityStarLightSignPart2View_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPart2View_1_3", ActivityStarLightSignViewBase_1_3)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle2"))
	slot0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlightfullbg2"))
end

return slot0
