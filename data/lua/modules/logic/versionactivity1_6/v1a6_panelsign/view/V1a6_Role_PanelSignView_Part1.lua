module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_Part1", package.seeall)

slot0 = class("V1a6_Role_PanelSignView_Part1", V1a6_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_sign_logo"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a6SignSingleBg("v1a6_quniang_sign_panelbg"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
