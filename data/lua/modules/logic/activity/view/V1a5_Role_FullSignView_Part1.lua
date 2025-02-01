module("modules.logic.activity.view.V1a5_Role_FullSignView_Part1", package.seeall)

slot0 = class("V1a5_Role_FullSignView_Part1", V1a5_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_kerandian_title"))
	slot0._simageFullBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_kerandian_sign_fullbg"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
