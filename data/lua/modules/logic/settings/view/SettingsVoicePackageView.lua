module("modules.logic.settings.view.SettingsVoicePackageView", package.seeall)

slot0 = class("SettingsVoicePackageView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "view/#scroll_content")
	slot0._btndownload = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btn/#btn_downloadall")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/#btn_close")
	slot0._btndelete = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btn/#btn_delete")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "view/bg/#simage_rightbg")
	slot0._txttips = gohelper.findChildText(slot0.viewGO, "view/#txt_desc")
	slot0._goon = gohelper.findChild(slot0.viewGO, "view/btn/#btn_delete/#go_on")
	slot0._gooff = gohelper.findChild(slot0.viewGO, "view/btn/#btn_delete/#go_off")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndownload:AddClickListener(slot0._btndownloadOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndelete:AddClickListener(slot0._btndeleteOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndownload:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btndelete:RemoveClickListener()
end

function slot0._btndeleteOnClick(slot0)
	if slot0._isNowOrDefault == false then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DeleteVoicePack, MsgBoxEnum.BoxType.Yes_No, function ()
			SettingsVoicePackageController.instance:deleteVoicePack(uv0._selectType)
		end, nil, , , , , luaLang(SettingsVoicePackageModel.instance:getPackInfo(slot0._selectType).nameLangId))
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btndownloadOnClick(slot0)
	slot1 = SettingsVoicePackageModel.instance:getPackInfo(slot0._selectType)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, {
		entrance = "package_manage",
		update_amount = slot1:getLeftSizeMBNum(),
		download_voice_pack_list = {
			slot1.lang
		},
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList(),
		current_language = GameConfig:GetCurLangShortcut(),
		current_voice_pack_used = GameConfig:GetCurVoiceShortcut()
	})
	slot0:closeThis()
	SettingsVoicePackageController.instance:tryDownload(slot1)
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._downOrderList = {}
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshButton()
end

function slot0.onOpen(slot0)
	slot0:_updateSelecet(GameConfig:GetCurVoiceShortcut())
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._refreshButton, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, slot0._updateSelecet, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._refreshButton, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, slot0._updateSelecet, slot0)
end

function slot0._updateSelecet(slot0, slot1)
	slot0._selectType = slot1

	slot0:_refreshButton()
end

function slot0._refreshButton(slot0)
	slot0._isNowOrDefault = slot0._selectType == GameConfig:GetCurVoiceShortcut() or slot0._selectType == GameConfig:GetDefaultVoiceShortcut()

	gohelper.setActive(slot0._btndownload, SettingsVoicePackageModel.instance:getPackInfo(slot0._selectType) and slot1:needDownload())
	gohelper.setActive(slot0._btndelete, slot1 and slot1:hasLocalFile() and not HotUpdateVoiceMgr.ForceSelect[slot0._selectType])
	gohelper.setActive(slot0._goon, slot0._isNowOrDefault == false)
	gohelper.setActive(slot0._gooff, slot0._isNowOrDefault)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
