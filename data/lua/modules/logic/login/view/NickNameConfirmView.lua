module("modules.logic.login.view.NickNameConfirmView", package.seeall)

slot0 = class("NickNameConfirmView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageinputnamebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_inputnamebg")
	slot0._simageconfirmbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_confirmbg")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#simage_inputnamebg/#txt_name")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "go/#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "go/#btn_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
end

function slot0._btnyesOnClick(slot0)
	PlayerRpc.instance:sendRenameRequest(slot0.sendRenameParam.name, slot0.sendRenameParam.guideId, slot0.sendRenameParam.stepId)
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmYes)
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmNo)
end

function slot0._editableInitView(slot0)
	slot0._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	slot0._simageconfirmbg:LoadImage(ResUrl.getNickNameIcon("shifouquerendi_003"))
	slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, slot0.closeThis, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.RenameReplyFail, slot0._btnnoOnClick, slot0)
	gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.Play_UI_OperaHouse)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	PostProcessingMgr.instance:setBlurWeight(1)

	slot0.sendRenameParam = slot0.viewParam
	slot0._txtname.text = slot0.sendRenameParam.name

	NavigateMgr.instance:addEscape(ViewName.NicknameConfirmView, slot0._btnnoOnClick, slot0)
end

function slot0.onClose(slot0)
	slot0._simageconfirmbg:UnLoadImage()
	slot0._simageinputnamebg:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	PostProcessingMgr.instance:setBlurWeight(0)
end

return slot0
