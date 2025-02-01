module("modules.logic.activity.view.ActivityStarLightSignPart2PaiLianView_1_3", package.seeall)

slot0 = class("ActivityStarLightSignPart2PaiLianView_1_3", ActivityStarLightSignPaiLianViewBase_1_3)

function slot0._editableInitView(slot0)
	slot0._actId = ActivityEnum.Activity.StarLightSignPart2_1_3

	slot0._simagePanelBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_starlighthalfbg2"))
	slot0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_starlighttitle2"))
end

return slot0
