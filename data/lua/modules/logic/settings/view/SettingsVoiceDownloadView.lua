module("modules.logic.settings.view.SettingsVoiceDownloadView", package.seeall)

local var_0_0 = class("SettingsVoiceDownloadView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/bg/#simage_leftbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "view/main/#txt_title2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "view/main/#txt_desc")
	arg_1_0._txtloading = gohelper.findChildText(arg_1_0.viewGO, "view/main/#txt_loading")
	arg_1_0._gobtnloading = gohelper.findChild(arg_1_0.viewGO, "view/#go_btnloading")
	arg_1_0._btncanceldownload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_btnloading/#btn_cancel")
	arg_1_0._goon = gohelper.findChild(arg_1_0.viewGO, "view/#go_btnloading/#btn_cancel/#go_on")
	arg_1_0._gooff = gohelper.findChild(arg_1_0.viewGO, "view/#go_btnloading/#btn_cancel/#go_off")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_btnloading/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	SettingsVoicePackageController.instance:register()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncanceldownload:AddClickListener(arg_2_0._btncanceldownloadOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncanceldownload:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	return
end

function var_0_0._btncanceldownloadOnClick(arg_5_0)
	SettingsVoicePackageController.instance:stopDownload(arg_5_0._mo)
	arg_5_0:closeThis()
end

function var_0_0._btnswitchOnClick(arg_6_0)
	if arg_6_0._mo.lang == "res-HD" then
		arg_6_0:closeThis()
		SettingsModel.instance:setVideoHDMode(true)
		SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeHDType)

		return
	end

	SettingsVoicePackageController.instance:switchVoiceType(arg_6_0._mo.lang, "in_voiceview")
	ToastController.instance:showToast(182)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._imgloading = gohelper.findChildImage(arg_7_0.viewGO, "view/main/loadingline/#img_loading")

	arg_7_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_7_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_7_0._txtcancel = gohelper.findChildText(arg_7_0.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancel")
	arg_7_0._txtcancelEn = gohelper.findChildText(arg_7_0.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancelen")
	arg_7_0._txtconfirm = gohelper.findChildText(arg_7_0.viewGO, "view/#go_btnloading/#btn_confirm/#txt_confirm")
	arg_7_0._goCanceldownload = arg_7_0._btncanceldownload.gameObject
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, arg_9_0._refreshDownloadProgress, arg_9_0)
	arg_9_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, arg_9_0._refreshUnzipProgress, arg_9_0)
	arg_9_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_9_0._onDownloadPackSuccess, arg_9_0)

	arg_9_0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	arg_9_0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	arg_9_0._eventMgrInst:AddLuaLisenter(arg_9_0._eventMgr.UnzipProgress, arg_9_0._refreshUnzipProgress, arg_9_0)

	arg_9_0._mo = arg_9_0.viewParam.packItemMO
	arg_9_0._txttitle2.text = formatLuaLang("voice_package_update_3", luaLang(arg_9_0._mo.nameLangId))
	arg_9_0._txtcancel.text = luaLang("voice_package_cancel_download")
	arg_9_0._txtcancelEn.text = "CANCEL"

	gohelper.setActive(arg_9_0._txtdesc.gameObject, false)
	gohelper.setActive(arg_9_0._btnswitch.gameObject, false)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0._eventMgrInst:ClearLuaListener()
	arg_10_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, arg_10_0._refreshDownloadProgress, arg_10_0)
	arg_10_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, arg_10_0._refreshUnzipProgress, arg_10_0)
	arg_10_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, arg_10_0._onDownloadPackSuccess, arg_10_0)
end

function var_0_0._refreshDownloadProgress(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = string.format("%0.2f", arg_11_2 / 1024 / 1024)
	arg_11_3 = string.format("%0.2f", arg_11_3 / 1024 / 1024)
	arg_11_0._imgloading.fillAmount = arg_11_2 / arg_11_3

	local var_11_0 = {
		arg_11_2 .. "MB",
		arg_11_3 .. "MB"
	}

	arg_11_0._txtloading.text = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_4"), var_11_0)
end

function var_0_0._refreshUnzipProgress(arg_12_0, arg_12_1)
	arg_12_0._imgloading.fillAmount = arg_12_1
	arg_12_0._txtloading.text = luaLang("voice_package_unzip")

	gohelper.setActive(arg_12_0._goCanceldownload, false)
end

function var_0_0._onDownloadPackSuccess(arg_13_0)
	arg_13_0._txtcancel.text = luaLang("cancel")
	arg_13_0._txtcancelEn.text = "CANCEL"
	arg_13_0._txtconfirm.text = luaLang("confirm")
	arg_13_0._imgloading.fillAmount = 1
	arg_13_0._txtloading.text = ""

	gohelper.setActive(arg_13_0._btncanceldownload.gameObject, true)

	if arg_13_0._mo.lang == "res-HD" then
		gohelper.setActive(arg_13_0._txtdesc.gameObject, false)
		gohelper.setActive(arg_13_0._btncanceldownload, false)
	else
		gohelper.setActive(arg_13_0._txtdesc.gameObject, true)
	end

	gohelper.setActive(arg_13_0._btnswitch.gameObject, true)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simageleftbg:UnLoadImage()
	arg_14_0._simagerightbg:UnLoadImage()
end

return var_0_0
