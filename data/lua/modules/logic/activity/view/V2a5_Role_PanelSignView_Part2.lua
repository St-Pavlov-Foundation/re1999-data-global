module("modules.logic.activity.view.V2a5_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V2a5_Role_PanelSignView_Part2", V2a5_Role_PanelSignView)

function slot0._editableInitView(slot0)
	GameUtil.loadSImage(slot0._simagePanelBG, ResUrl.getV2a5SignSingleBg("v2a5_sign_panelbg2"))
	GameUtil.loadSImage(slot0._simageTitle, ResUrl.getV2a5SignSingleBgLang("v2a5_sign_titie_2"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
