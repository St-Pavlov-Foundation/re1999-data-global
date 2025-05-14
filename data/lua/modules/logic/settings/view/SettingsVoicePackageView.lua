module("modules.logic.settings.view.SettingsVoicePackageView", package.seeall)

local var_0_0 = class("SettingsVoicePackageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "view/#scroll_content")
	arg_1_0._btndownload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btn/#btn_downloadall")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._btndelete = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/btn/#btn_delete")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_rightbg")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "view/#txt_desc")
	arg_1_0._goon = gohelper.findChild(arg_1_0.viewGO, "view/btn/#btn_delete/#go_on")
	arg_1_0._gooff = gohelper.findChild(arg_1_0.viewGO, "view/btn/#btn_delete/#go_off")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndownload:AddClickListener(arg_2_0._btndownloadOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndelete:AddClickListener(arg_2_0._btndeleteOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndownload:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndelete:RemoveClickListener()
end

function var_0_0._btndeleteOnClick(arg_4_0)
	if arg_4_0._isNowOrDefault == false then
		local var_4_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_4_0._selectType)

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DeleteVoicePack, MsgBoxEnum.BoxType.Yes_No, function()
			SettingsVoicePackageController.instance:deleteVoicePack(arg_4_0._selectType)
		end, nil, nil, nil, nil, nil, luaLang(var_4_0.nameLangId))
	end
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btndownloadOnClick(arg_7_0)
	local var_7_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_7_0._selectType)
	local var_7_1 = {}

	var_7_1.entrance = "package_manage"
	var_7_1.update_amount = var_7_0:getLeftSizeMBNum()
	var_7_1.download_voice_pack_list = {
		var_7_0.lang
	}
	var_7_1.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
	var_7_1.current_language = GameConfig:GetCurLangShortcut()
	var_7_1.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, var_7_1)
	arg_7_0:closeThis()
	SettingsVoicePackageController.instance:tryDownload(var_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_8_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_8_0._downOrderList = {}
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshButton()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_updateSelecet(GameConfig:GetCurVoiceShortcut())
	arg_10_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_10_0._refreshButton, arg_10_0)
	arg_10_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, arg_10_0._updateSelecet, arg_10_0)
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_11_0._refreshButton, arg_11_0)
	arg_11_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, arg_11_0._updateSelecet, arg_11_0)
end

function var_0_0._updateSelecet(arg_12_0, arg_12_1)
	arg_12_0._selectType = arg_12_1

	arg_12_0:_refreshButton()
end

function var_0_0._refreshButton(arg_13_0)
	arg_13_0._isNowOrDefault = arg_13_0._selectType == GameConfig:GetCurVoiceShortcut() or arg_13_0._selectType == GameConfig:GetDefaultVoiceShortcut()

	local var_13_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_13_0._selectType)

	gohelper.setActive(arg_13_0._btndownload, var_13_0 and var_13_0:needDownload())
	gohelper.setActive(arg_13_0._btndelete, var_13_0 and var_13_0:hasLocalFile() and not HotUpdateVoiceMgr.ForceSelect[arg_13_0._selectType])
	gohelper.setActive(arg_13_0._goon, arg_13_0._isNowOrDefault == false)
	gohelper.setActive(arg_13_0._gooff, arg_13_0._isNowOrDefault)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simageleftbg:UnLoadImage()
	arg_14_0._simagerightbg:UnLoadImage()
end

return var_0_0
