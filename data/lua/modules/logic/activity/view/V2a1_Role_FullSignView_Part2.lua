module("modules.logic.activity.view.V2a1_Role_FullSignView_Part2", package.seeall)

slot0 = class("V2a1_Role_FullSignView_Part2", V2a1_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV2a1SignSingleBg("v2a1_sign_fullbg2"))
	slot0._simageTitle:LoadImage(ResUrl.getV2a1SignSingleBgLang("v2a1_sign_title2"))
end

return slot0
