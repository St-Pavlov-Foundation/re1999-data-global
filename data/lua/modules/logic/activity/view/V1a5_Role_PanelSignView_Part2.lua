module("modules.logic.activity.view.V1a5_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V1a5_Role_PanelSignView_Part2", V1a5_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_aizila_title"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_aizila_sign_panelbg"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
