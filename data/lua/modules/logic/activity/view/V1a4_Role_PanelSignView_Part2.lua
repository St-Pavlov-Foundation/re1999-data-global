module("modules.logic.activity.view.V1a4_Role_PanelSignView_Part2", package.seeall)

slot0 = class("V1a4_Role_PanelSignView_Part2", V1a4_Role_PanelSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a4SignSingleBgLang("v1a4_sign_paneltitle2"))
	slot0._simagePanelBG:LoadImage(ResUrl.getV1a4SignSingleBg("v1a4_role6_sign_panelbg"))
end

return slot0
