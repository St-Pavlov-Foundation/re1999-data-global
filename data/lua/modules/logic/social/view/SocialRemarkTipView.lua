module("modules.logic.social.view.SocialRemarkTipView", package.seeall)

slot0 = class("SocialRemarkTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "main/bg/#simage_left")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "main/bg/#simage_right")
	slot0._inputsignature = gohelper.findChildTextMeshInputField(slot0.viewGO, "main/bg/textArea/#input_signature")
	slot0._btncleanname = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/bg/textArea/#btn_cleanname")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/bg/btnnode/#btn_cancel")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "main/bg/btnnode/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncleanname:AddClickListener(slot0._clickClean, slot0)
	slot0._btncancel:AddClickListener(slot0.closeThis, slot0)
	slot0._btnconfirm:AddClickListener(slot0._clickConfirm, slot0)
	slot0._inputsignature:AddOnValueChanged(slot0._onValueChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncleanname:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._inputsignature:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "main/bg/#simage_bg2")
end

function slot0._clickConfirm(slot0)
	FriendRpc.instance:changeDesc(slot0.viewParam.userId, slot0._inputsignature:GetText())
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._inputsignature:SetText(slot0.viewParam.desc)
	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot0.viewParam.desc))
end

function slot0._clickClean(slot0)
	slot0._inputsignature:SetText("")
end

function slot0._onValueChange(slot0)
	slot1 = slot0._inputsignature:GetText()
	slot3 = GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)))

	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot3))

	if slot3 == slot1 then
		return
	end

	slot0._inputsignature:SetText(slot3)
end

return slot0
