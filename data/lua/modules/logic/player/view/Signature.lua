module("modules.logic.player.view.Signature", package.seeall)

slot0 = class("Signature", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_leftbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._inputsignature = gohelper.findChildTextMeshInputField(slot0.viewGO, "message/#input_signature")
	slot0._txttext = gohelper.findChildText(slot0.viewGO, "message/#input_signature/textarea/#txt_text")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsureOnClick(slot0)
	if slot0._inputsignature:GetText() == PlayerModel.instance:getPlayinfo().signature then
		slot0:closeThis()

		return
	end

	PlayerRpc.instance:sendSetSignatureRequest(slot1, slot0._modifiedSuccess, slot0)
end

function slot0._modifiedSuccess(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnsure.gameObject, AudioEnum.UI.UI_Common_Click)
	slot0._inputsignature:SetCharacterLimit(CommonConfig.instance:getConstNum(ConstEnum.PlayerENameLimit))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._inputsignature:SetText(PlayerModel.instance:getPlayinfo().signature)
	NavigateMgr.instance:addEscape(ViewName.Signature, slot0._btncloseOnClick, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
