module("modules.logic.settings.view.SettingsVoicePackageListItem", package.seeall)

slot0 = class("SettingsVoicePackageListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtname1 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_name")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_name")
	slot0._txtsize1 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_size")
	slot0._txtsize2 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_size")
	slot0._txtVersion = gohelper.findChildText(slot0.viewGO, "#txt_version")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_unselected")
	slot0._gocur1 = gohelper.findChild(slot0.viewGO, "#go_selected/#txt_selected")
	slot0._gocur2 = gohelper.findChild(slot0.viewGO, "#go_unselected/#txt_selected")
	slot0._goNowIcon1 = gohelper.findChild(slot0.viewGO, "#go_selected/#txt_name/#go_icon")
	slot0._goNowIcon2 = gohelper.findChild(slot0.viewGO, "#go_unselected/#txt_name/#go_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btndownloadOnClick(slot0)
	slot1 = slot0._mo:getStatus()

	logWarn("SettingsVoicePackageListItem _btndownloadOnClick self._mo.lang = " .. slot0._mo.lang .. " status = " .. slot1)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)

	if slot1 == SettingsVoicePackageController.NotDownload or slot1 == SettingsVoicePackageController.NeedUpdate then
		SettingsVoicePackageController.instance:startDownload(slot0._mo)
	end
end

function slot0._btnstopdownloadOnClick(slot0)
	SettingsVoicePackageController.instance:stopDownload(slot0._mo)
end

function slot0._editableInitView(slot0)
	slot0._gotogclick = gohelper.findChild(slot0.viewGO, "#go_togclick")
	slot0._btn = gohelper.getClickWithAudio(slot0._gotogclick)
end

function slot0._editableAddEvents(slot0)
	slot0._btn:AddClickListener(slot0._onClick, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._onPackItemStateChange, slot0)
	slot0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, slot0._updateSelecet, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._btn:RemoveClickListener()
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, slot0._onPackItemStateChange, slot0)
	slot0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, slot0._updateSelecet, slot0)
end

function slot0._onPackItemStateChange(slot0, slot1, slot2)
	if slot0._mo.lang ~= slot1 then
		return
	end

	slot0:_updateStatus()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	if slot0._mo.lang == GameConfig:GetDefaultVoiceShortcut() or HotUpdateVoiceMgr.IsGuoFu and HotUpdateVoiceMgr.ForceSelect[slot0._mo.lang] then
		slot2 = formatLuaLang("voice_package_default", luaLang(slot1.nameLangId))
		slot0._txtname2.alpha = 0.8
	else
		slot0._txtname2.alpha = 1
	end

	slot0._txtname1.text = slot2
	slot0._txtname2.text = slot2
	slot6 = GameConfig:GetCurVoiceShortcut()

	slot0:_updateSelecet(slot6)

	slot7 = slot6 == slot0._mo.lang

	gohelper.setActive(slot0._gocur1, slot7)
	gohelper.setActive(slot0._gocur2, slot7)
	gohelper.setActive(slot0._goNowIcon1, slot7)
	gohelper.setActive(slot0._goNowIcon2, slot7)
	slot0:_updateStatus()

	if slot0._txtVersion then
		slot0._txtVersion.text = slot0:_getLangCurVersion(slot0._mo.lang, slot3)
	end
end

function slot0._getLangCurVersion(slot0, slot1, slot2)
	if HotUpdateVoiceMgr.IsGuoFu and slot1 == slot2 then
		slot1 = HotUpdateVoiceMgr.LangZh
	end

	slot3 = SLFramework.GameUpdate.OptionalUpdate.Instance
	slot4 = slot3.VoiceBranch

	if string.nilorempty(slot3:GetLocalVersion(slot1)) then
		return ""
	end

	return string.format("V.%s.%s", tostring(slot4), tostring(slot5))
end

function slot0._updateStatus(slot0, slot1, slot2)
	if slot0._mo:getStatus() == SettingsVoicePackageController.NotDownload or slot3 == SettingsVoicePackageController.NeedUpdate then
		slot5, slot6, slot7 = slot0._mo:getLeftSizeMBorGB()
		slot9 = string.format(slot3 == SettingsVoicePackageController.NeedUpdate and luaLang("voice_package_update_5") or "(%s)", string.format("%.2f%s", slot5, slot7))
		slot0._txtsize1.text = slot9
		slot0._txtsize2.text = slot9
	else
		slot0._txtsize1.text = ""
		slot0._txtsize2.text = ""
	end
end

function slot0._onClick(slot0)
	SettingsVoicePackageController.instance:dispatchEvent(SettingsEvent.OnChangeSelecetDownloadVoicePack, slot0._mo.lang)
end

function slot0._updateSelecet(slot0, slot1)
	slot2 = slot1 == slot0._mo.lang

	gohelper.setActive(slot0._goselected, slot2)
	gohelper.setActive(slot0._gounselected, slot2 == false)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
