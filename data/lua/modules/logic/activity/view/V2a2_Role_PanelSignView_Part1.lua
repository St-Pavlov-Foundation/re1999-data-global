module("modules.logic.activity.view.V2a2_Role_PanelSignView_Part1", package.seeall)

slot0 = class("V2a2_Role_PanelSignView_Part1", V2a2_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simagePanelBG:LoadImage(ResUrl.getV2a2SignSingleBg("v2a2_sign_panelbg1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
