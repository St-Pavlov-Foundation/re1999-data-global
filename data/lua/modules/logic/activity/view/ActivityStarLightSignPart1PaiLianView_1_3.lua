module("modules.logic.activity.view.ActivityStarLightSignPart1PaiLianView_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPart1PaiLianView_1_3", ActivityStarLightSignPaiLianViewBase_1_3)

function slot0._editableInitView(slot0)
	slot0._actId = ActivityEnum.Activity.StarLightSignPart1_1_3

	slot0._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlighthalfbg1"))
	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle1"))
end

return slot0
