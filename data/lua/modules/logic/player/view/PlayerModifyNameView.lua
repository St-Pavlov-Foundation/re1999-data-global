module("modules.logic.player.view.PlayerModifyNameView", package.seeall)

slot0 = class("PlayerModifyNameView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "window/#simage_leftbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_sure")
	slot0._inputsignature = gohelper.findChildTextMeshInputField(slot0.viewGO, "message/#input_signature")
	slot0._txttext = gohelper.findChildText(slot0.viewGO, "message/#input_signature/textarea/#txt_text")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "tips/#txt_tip")
	slot0._btncleanname = gohelper.findChildButtonWithAudio(slot0.viewGO, "message/#btn_cleanname")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._btncleanname:AddClickListener(slot0._onBtnClean, slot0)
	slot0._inputsignature:AddOnValueChanged(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
	slot0._btncleanname:RemoveClickListener()
	slot0._inputsignature:RemoveOnValueChanged()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
end

function slot0._btnsureOnClick(slot0)
	if PlayerModel.instance:getExtraRename() < 1 and not PlayerModel.instance:getCanRename() then
		GameFacade.showToast(ToastEnum.PlayerModifyExtraName)

		return
	end

	slot0:checkLimit()

	if string.nilorempty(slot0._inputsignature:GetText()) then
		return
	end

	PlayerRpc.instance:sendRenameRequest(slot1)
end

function slot0._onEndEdit(slot0)
	slot0:checkLimit()
end

function slot0._onBtnClean(slot0)
	slot0._inputsignature:SetText("")
end

function slot0.checkLimit(slot0)
	slot1 = slot0._inputsignature:GetText()
	slot1 = GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)))

	slot0._inputsignature:SetText(slot1)
	gohelper.setActive(slot0._btncleanname, not string.nilorempty(slot1))
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, slot0._onNameChanged, slot0)

	if PlayerModel.instance:getExtraRename() > 0 then
		slot0._txttip.text = luaLang("p_player_rename_tip_extra")
	elseif PlayerModel.instance:getCanRename() then
		slot0._txttip.text = luaLang("p_player_rename_tip")
	else
		slot0._txttip.text = luaLang("p_player_rename_tip_no_count")
	end

	gohelper.setActive(slot0._btncleanname, false)
end

function slot0.onClose(slot0)
end

function slot0._onNameChanged(slot0)
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

return slot0
