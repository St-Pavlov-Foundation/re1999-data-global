module("modules.logic.settings.view.SettingsCdkeyView", package.seeall)

local var_0_0 = class("SettingsCdkeyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_leftbg")
	arg_1_0._inputcdkey = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#input_cdkey")
	arg_1_0._goplaceholdertext = gohelper.findChildText(arg_1_0.viewGO, "#input_cdkey/Text Area/Placeholder")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_close")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_sure")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
	arg_2_0._inputcdkey:AddOnEndEdit(arg_2_0._onInputCdkeyEndEdit, arg_2_0)
	arg_2_0._inputcdkey:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsure:RemoveClickListener()
	arg_3_0._inputcdkey:RemoveOnEndEdit()
	arg_3_0._inputcdkey:RemoveOnValueChanged()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = arg_5_0._inputcdkey:GetText()

	if string.nilorempty(var_5_0) then
		GameFacade.showToast(ToastEnum.SettingsCdkeyIsNull)

		return
	end

	PlayerRpc.instance:sendUseCdKeyRequset(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_6_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	SLFramework.UGUI.UIClickListener.Get(arg_6_0._inputcdkey.gameObject):AddClickListener(arg_6_0._hidePlaceholderText, arg_6_0)
	arg_6_0:addEventCb(SettingsController.instance, SettingsEvent.OnUseCdkReplay, arg_6_0.onUseCdkReplay, arg_6_0)
end

function var_0_0._hidePlaceholderText(arg_7_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_7_0._goplaceholdertext, 0)
end

function var_0_0._onValueChanged(arg_8_0, arg_8_1)
	if GameUtil.utf8len(arg_8_1) > 50 then
		arg_8_0._inputcdkey:SetText(GameUtil.utf8sub(arg_8_1, 1, 50))
	end
end

function var_0_0._onInputCdkeyEndEdit(arg_9_0)
	ZProj.UGUIHelper.SetColorAlpha(arg_9_0._goplaceholdertext, 0.6)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	return
end

function var_0_0.onUseCdkReplay(arg_12_0)
	arg_12_0._inputcdkey:SetText("")
end

function var_0_0.onClose(arg_13_0)
	SLFramework.UGUI.UIClickListener.Get(arg_13_0._inputcdkey.gameObject):RemoveClickListener()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simageleftbg:UnLoadImage()
	arg_14_0._simagerightbg:UnLoadImage()
end

return var_0_0
