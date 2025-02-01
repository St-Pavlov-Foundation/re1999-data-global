module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V1a6_Role_PanelSignView_Part2", V1a6_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_sign_logo"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_getian_sign_panelbg"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
