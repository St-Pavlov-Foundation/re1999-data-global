module("modules.logic.activity.view.V1a8_Role_PanelSignView_Part1", package.seeall)

slot0 = class("V1a8_Role_PanelSignView_Part1", V1a8_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title1"))
	slot0._simageTitle_eff:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_panel_title1"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a8SignSingleBg("v1a8_sign_panel_bg1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
