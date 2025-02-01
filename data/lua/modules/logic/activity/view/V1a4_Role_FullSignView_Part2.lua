module("modules.logic.activity.view.V1a4_Role_FullSignView_Part2", package.seeall)

slot0 = class("V1a4_Role_FullSignView_Part2", V1a4_Role_FullSignView)

function slot0._editableInitView(slot0)
	slot0._simageTitle:LoadImage(ResUrl.getV1a4SignSingleBgLang("v1a4_sign_fulltitle2"))
	slot0._simageFullBG:LoadImage(ResUrl.getV1a4SignSingleBg("v1a4_role37_sign_fullbg"))
end

return slot0
