module("modules.logic.activity.view.V2a2_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V2a2_Role_PanelSignView_Part2", V2a2_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simagePanelBG:LoadImage(ResUrl.getV2a2SignSingleBg("v2a2_sign_panelbg2"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
