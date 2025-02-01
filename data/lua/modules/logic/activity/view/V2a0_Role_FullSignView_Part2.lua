module("modules.logic.activity.view.V2a0_Role_FullSignView_Part2", package.seeall)

slot0 = class("V2a0_Role_FullSignView_Part2", V2a0_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_sign_fullbg1"))
	slot0._simageTitle:LoadImage(ResUrl.getV2a0SignSingleBgLang("v2a0_sign_title2"))
end

return slot0
