module("modules.logic.activity.view.V2a4_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V2a4_Role_PanelSignView_Part2", V2a4_Role_PanelSignView)

function slot0._editableInitView(slot0)
	GameUtil.loadSImage(slot0._simagePanelBG, ResUrl.getV2a4SignSingleBg("v2a4_sign_panelbg2"))

	slot1 = ResUrl.getV2a4SignSingleBgLang("v2a4_sign_title_2")

	GameUtil.loadSImage(slot0._simageTitle, slot1)
	GameUtil.loadSImage(slot0._simageTitle_glow, slot1)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
