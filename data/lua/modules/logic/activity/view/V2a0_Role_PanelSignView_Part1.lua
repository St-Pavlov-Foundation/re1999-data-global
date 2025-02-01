module("modules.logic.activity.view.V2a0_Role_PanelSignView_Part1", package.seeall)

slot0 = class("V2a0_Role_PanelSignView_Part1", V2a0_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simagePanelBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_panelbg2"))
	slot0._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title1"))
end

return slot0
