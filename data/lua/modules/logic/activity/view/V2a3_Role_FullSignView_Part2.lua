module("modules.logic.activity.view.V2a3_Role_FullSignView_Part2", package.seeall)

slot0 = class("V2a3_Role_FullSignView_Part2", V2a3_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV2a3SignSingleBg("v2a3_sign_fullbg2"))
	slot0._simageTitle:LoadImage(ResUrl.getV2a3SignSingleBgLang("v2a3_sign_titie_2"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), true)
end

return slot0
