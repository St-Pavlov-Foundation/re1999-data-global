module("modules.logic.settings.view.SettingsVoiceDownloadView", package.seeall)

slot0 = class("SettingsVoiceDownloadView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_leftbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_close")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "view/main/#txt_title2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "view/main/#txt_desc")
	slot0._txtloading = gohelper.findChildText(slot0.viewGO, "view/main/#txt_loading")
	slot0._gobtnloading = gohelper.findChild(slot0.viewGO, "view/#go_btnloading")
	slot0._btncanceldownload = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#go_btnloading/#btn_cancel")
	slot0._goon = gohelper.findChild(slot0.viewGO, "view/#go_btnloading/#btn_cancel/#go_on")
	slot0._gooff = gohelper.findChild(slot0.viewGO, "view/#go_btnloading/#btn_cancel/#go_off")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#go_btnloading/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	SettingsVoicePackageController.instance:register()
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncanceldownload:AddClickListener(slot0._btncanceldownloadOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncanceldownload:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
end

function slot0._btncanceldownloadOnClick(slot0)
	SettingsVoicePackageController.instance:stopDownload(slot0._mo)
	slot0:closeThis()
end

function slot0._btnswitchOnClick(slot0)
	if slot0._mo.lang == "res-HD" then
		slot0:closeThis()
		SettingsModel.instance:setVideoHDMode(true)
		SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeHDType)

		return
	end

	SettingsVoicePackageController.instance:switchVoiceType(slot0._mo.lang, "in_voiceview")
	ToastController.instance:showToast(182)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._imgloading = gohelper.findChildImage(slot0.viewGO, "view/main/loadingline/#img_loading")

	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._txtcancel = gohelper.findChildText(slot0.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancel")
	slot0._txtcancelEn = gohelper.findChildText(slot0.viewGO, "view/#go_btnloading/#btn_cancel/#txt_cancelen")
	slot0._txtconfirm = gohelper.findChildText(slot0.viewGO, "view/#go_btnloading/#btn_confirm/#txt_confirm")
	slot0._goCanceldownload = slot0._btncanceldownload.gameObject
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, slot0._refreshDownloadProgress, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, slot0._refreshUnzipProgress, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)

	slot0._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	slot0._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

	slot0._eventMgrInst:AddLuaLisenter(slot0._eventMgr.UnzipProgress, slot0._refreshUnzipProgress, slot0)

	slot0._mo = slot0.viewParam.packItemMO
	slot0._txttitle2.text = formatLuaLang("voice_package_update_3", luaLang(slot0._mo.nameLangId))
	slot0._txtcancel.text = luaLang("voice_package_cancel_download")
	slot0._txtcancelEn.text = "CANCEL"

	gohelper.setActive(slot0._txtdesc.gameObject, false)
	gohelper.setActive(slot0._btnswitch.gameObject, false)
end

function slot0.onClose(slot0)
	slot0._eventMgrInst:ClearLuaListener()
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadProgressRefresh, slot0._refreshDownloadProgress, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnUnzipProgressRefresh, slot0._refreshUnzipProgress, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnDownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)
end

function slot0._refreshDownloadProgress(slot0, slot1, slot2, slot3)
	slot2 = string.format("%0.2f", slot2 / 1024 / 1024)
	slot3 = string.format("%0.2f", slot3 / 1024 / 1024)
	slot0._imgloading.fillAmount = slot2 / slot3
	slot0._txtloading.text = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_4"), {
		slot2 .. "MB",
		slot3 .. "MB"
	})
end

function slot0._refreshUnzipProgress(slot0, slot1)
	slot0._imgloading.fillAmount = slot1
	slot0._txtloading.text = luaLang("voice_package_unzip")

	gohelper.setActive(slot0._goCanceldownload, false)
end

function slot0._onDownloadPackSuccess(slot0)
	slot0._txtcancel.text = luaLang("cancel")
	slot0._txtcancelEn.text = "CANCEL"
	slot0._txtconfirm.text = luaLang("confirm")
	slot0._imgloading.fillAmount = 1
	slot0._txtloading.text = ""

	gohelper.setActive(slot0._btncanceldownload.gameObject, true)

	if slot0._mo.lang == "res-HD" then
		gohelper.setActive(slot0._txtdesc.gameObject, false)
		gohelper.setActive(slot0._btncanceldownload, false)
	else
		gohelper.setActive(slot0._txtdesc.gameObject, true)
	end

	gohelper.setActive(slot0._btnswitch.gameObject, true)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
