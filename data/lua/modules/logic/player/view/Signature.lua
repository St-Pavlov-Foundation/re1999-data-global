module("modules.logic.player.view.Signature", package.seeall)

local var_0_0 = class("Signature", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "window/#simage_leftbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_sure")
	arg_1_0._inputsignature = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "message/#input_signature")
	arg_1_0._txttext = gohelper.findChildText(arg_1_0.viewGO, "message/#input_signature/textarea/#txt_text")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = arg_5_0._inputsignature:GetText()

	if var_5_0 == PlayerModel.instance:getPlayinfo().signature then
		arg_5_0:closeThis()

		return
	end

	PlayerRpc.instance:sendSetSignatureRequest(var_5_0, arg_5_0._modifiedSuccess, arg_5_0)
end

function var_0_0._modifiedSuccess(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == 0 then
		arg_6_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_7_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.addUIClickAudio(arg_7_0._btnclose.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_7_0._btnsure.gameObject, AudioEnum.UI.UI_Common_Click)
	arg_7_0._inputsignature:SetCharacterLimit(CommonConfig.instance:getConstNum(ConstEnum.PlayerENameLimit))
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = PlayerModel.instance:getPlayinfo().signature

	arg_9_0._inputsignature:SetText(var_9_0)
	NavigateMgr.instance:addEscape(ViewName.Signature, arg_9_0._btncloseOnClick, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageleftbg:UnLoadImage()
	arg_11_0._simagerightbg:UnLoadImage()
end

return var_0_0
