module("modules.logic.activity.view.V2a3_Role_FullSignView_Part1", package.seeall)

slot0 = class("V2a3_Role_FullSignView_Part1", V2a3_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV2a3SignSingleBg("v2a3_sign_fullbg1"))
	slot0._simageTitle:LoadImage(ResUrl.getV2a3SignSingleBgLang("v2a3_sign_titie_1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
