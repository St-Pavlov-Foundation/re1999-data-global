module("modules.logic.activity.view.V1a7_Role_FullSignView_Part1", package.seeall)

slot0 = class("V1a7_Role_FullSignView_Part1", V1a7_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title1"))
	slot0._simageTitle_eff:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title1"))
	slot0._simageFullBG:LoadImage(ResUrl.getV1a7SignSingleBg("v1a7_role_fullsignview_bg_1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
