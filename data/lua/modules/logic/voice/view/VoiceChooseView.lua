module("modules.logic.voice.view.VoiceChooseView", package.seeall)

local var_0_0 = class("VoiceChooseView", BaseView)
local var_0_1 = "BootVoiceDownload"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnConfirm = gohelper.findChildButton(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_leftbg")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_rightbg")

	arg_1_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_1_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnConfirm:AddClickListener(arg_2_0._onClickConfirm, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnConfirm:RemoveClickListener()
end

function var_0_0._onClickConfirm(arg_4_0)
	local var_4_0 = VoiceChooseModel.instance:getChoose()

	PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, var_4_0)
	logNormal("selectLang = " .. var_4_0)
	SettingsVoicePackageController.instance:switchVoiceType(var_4_0, "after_download")
	arg_4_0:closeThis()

	if arg_4_0._callback then
		arg_4_0._callback(arg_4_0._callbackObj)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._callback = arg_5_0.viewParam.callback
	arg_5_0._callbackObj = arg_5_0.viewParam.callbackObj

	UpdateBeat:Add(arg_5_0._onFrame, arg_5_0)
end

function var_0_0.onClose(arg_6_0)
	UpdateBeat:Remove(arg_6_0._onFrame, arg_6_0)
end

function var_0_0._onFrame(arg_7_0)
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg2:UnLoadImage()
end

return var_0_0
