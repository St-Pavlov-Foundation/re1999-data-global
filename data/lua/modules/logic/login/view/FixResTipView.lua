module("modules.logic.login.view.FixResTipView", package.seeall)

local var_0_0 = class("FixResTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntouchClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_touchClose")
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "centerTip/#txt_tip")
	arg_1_0._toggletip = gohelper.findChildToggle(arg_1_0.viewGO, "centerTip/#toggle_tip")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnfix = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fix")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntouchClose:AddClickListener(arg_2_0._btntouchCloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnfix:AddClickListener(arg_2_0._btnfixOnClick, arg_2_0)
	arg_2_0._toggletip:AddOnValueChanged(arg_2_0._toggleTipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntouchClose:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnfix:RemoveClickListener()
	arg_3_0._toggletip:RemoveOnValueChanged()
end

function var_0_0._btntouchCloseOnClick(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnfixOnClick(arg_6_0)
	if arg_6_0._toggletip.isOn then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.Manual_FixRes, 1)
		SLFramework.FileHelper.DeleteFile(SLFramework.ResChecker.OutVersionPath)
		GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function()
			PlayerPrefsHelper.save()

			if BootNativeUtil.isAndroid() then
				if SDKMgr.restartGame ~= nil then
					SDKMgr.instance:restartGame()
				else
					ProjBooter.instance:quitGame()
				end
			else
				ProjBooter.instance:quitGame()
			end
		end)
	elseif arg_6_0.viewParam.callback then
		arg_6_0.viewParam.callback(arg_6_0.viewParam.callbackObj)
	end

	arg_6_0:closeThis()
end

function var_0_0._toggleTipOnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._toggletip.isOn = true

	arg_9_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	NavigateMgr.instance:addEscape(arg_11_0.viewName, arg_11_0._btncloseOnClick, arg_11_0)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagetipbg:UnLoadImage()
end

return var_0_0
