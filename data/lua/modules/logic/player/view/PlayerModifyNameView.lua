module("modules.logic.player.view.PlayerModifyNameView", package.seeall)

local var_0_0 = class("PlayerModifyNameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_leftbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._inputsignature = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "message/#input_signature")
	arg_1_0._txttext = gohelper.findChildText(arg_1_0.viewGO, "message/#input_signature/textarea/#txt_text")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "tips/#txt_tip")
	arg_1_0._btncleanname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "message/#btn_cleanname")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._btncleanname:AddClickListener(arg_2_0._onBtnClean, arg_2_0)
	arg_2_0._inputsignature:AddOnValueChanged(arg_2_0._onEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._btncleanname:RemoveClickListener()
	arg_3_0._inputsignature:RemoveOnValueChanged()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickModalMask(arg_5_0)
	return
end

function var_0_0._btnsureOnClick(arg_6_0)
	if PlayerModel.instance:getExtraRename() < 1 and not PlayerModel.instance:getCanRename() then
		GameFacade.showToast(ToastEnum.PlayerModifyExtraName)

		return
	end

	arg_6_0:checkLimit()

	local var_6_0 = arg_6_0._inputsignature:GetText()

	if string.nilorempty(var_6_0) then
		return
	end

	PlayerRpc.instance:sendRenameRequest(var_6_0)
end

function var_0_0._onEndEdit(arg_7_0)
	arg_7_0:checkLimit()
end

function var_0_0._onBtnClean(arg_8_0)
	arg_8_0._inputsignature:SetText("")
end

function var_0_0.checkLimit(arg_9_0)
	local var_9_0 = arg_9_0._inputsignature:GetText()
	local var_9_1 = CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)
	local var_9_2 = GameUtil.utf8sub(var_9_0, 1, math.min(GameUtil.utf8len(var_9_0), var_9_1))

	arg_9_0._inputsignature:SetText(var_9_2)
	gohelper.setActive(arg_9_0._btncleanname, not string.nilorempty(var_9_2))
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_10_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerName, arg_12_0._onNameChanged, arg_12_0)

	if PlayerModel.instance:getExtraRename() > 0 then
		arg_12_0._txttip.text = luaLang("p_player_rename_tip_extra")
	elseif PlayerModel.instance:getCanRename() then
		arg_12_0._txttip.text = luaLang("p_player_rename_tip")
	else
		arg_12_0._txttip.text = luaLang("p_player_rename_tip_no_count")
	end

	gohelper.setActive(arg_12_0._btncleanname, false)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0._onNameChanged(arg_14_0)
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
	arg_14_0:closeThis()
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
