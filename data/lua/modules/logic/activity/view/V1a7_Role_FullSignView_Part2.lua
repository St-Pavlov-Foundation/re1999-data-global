module("modules.logic.activity.view.V1a7_Role_FullSignView_Part2", package.seeall)

slot0 = class("V1a7_Role_FullSignView_Part2", V1a7_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title2"))
	slot0._simageTitle_eff:LoadImage(ResUrl.getV1a7SignSingleBgLang("v1a7_sign_panel_title2"))
	slot0._simageFullBG:LoadImage(ResUrl.getV1a7SignSingleBg("v1a7_role_fullsignview_bg_2"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
