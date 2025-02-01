module("modules.logic.activity.view.V2a2_Role_FullSignView_Part1", package.seeall)

slot0 = class("V2a2_Role_FullSignView_Part1", V2a2_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV2a2SignSingleBg("v2a2_sign_fullbg1"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
end

return slot0
