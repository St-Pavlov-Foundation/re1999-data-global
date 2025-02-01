module("modules.logic.activity.view.V1a9_Role_PanelSignView_Part1", package.seeall)

slot0 = class("V1a9_Role_PanelSignView_Part1", V1a9_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a9SignSingleBg("v1a9_sign_panelbg1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
