module("modules.logic.settings.view.SettingsVoicePackageListItem", package.seeall)

local var_0_0 = class("SettingsVoicePackageListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname1 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_name")
	arg_1_0._txtname2 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_name")
	arg_1_0._txtsize1 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_size")
	arg_1_0._txtsize2 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_size")
	arg_1_0._txtVersion = gohelper.findChildText(arg_1_0.viewGO, "#txt_version")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_unselected")
	arg_1_0._gocur1 = gohelper.findChild(arg_1_0.viewGO, "#go_selected/#txt_selected")
	arg_1_0._gocur2 = gohelper.findChild(arg_1_0.viewGO, "#go_unselected/#txt_selected")
	arg_1_0._goNowIcon1 = gohelper.findChild(arg_1_0.viewGO, "#go_selected/#txt_name/#go_icon")
	arg_1_0._goNowIcon2 = gohelper.findChild(arg_1_0.viewGO, "#go_unselected/#txt_name/#go_icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btndownloadOnClick(arg_4_0)
	local var_4_0 = arg_4_0._mo:getStatus()

	logWarn("SettingsVoicePackageListItem _btndownloadOnClick self._mo.lang = " .. arg_4_0._mo.lang .. " status = " .. var_4_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)

	if var_4_0 == SettingsVoicePackageController.NotDownload or var_4_0 == SettingsVoicePackageController.NeedUpdate then
		SettingsVoicePackageController.instance:startDownload(arg_4_0._mo)
	end
end

function var_0_0._btnstopdownloadOnClick(arg_5_0)
	SettingsVoicePackageController.instance:stopDownload(arg_5_0._mo)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._gotogclick = gohelper.findChild(arg_6_0.viewGO, "#go_togclick")
	arg_6_0._btn = gohelper.getClickWithAudio(arg_6_0._gotogclick)
end

function var_0_0._editableAddEvents(arg_7_0)
	arg_7_0._btn:AddClickListener(arg_7_0._onClick, arg_7_0)
	arg_7_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_7_0._onPackItemStateChange, arg_7_0)
	arg_7_0:addEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, arg_7_0._updateSelecet, arg_7_0)
end

function var_0_0._editableRemoveEvents(arg_8_0)
	arg_8_0._btn:RemoveClickListener()
	arg_8_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnPackItemStateChange, arg_8_0._onPackItemStateChange, arg_8_0)
	arg_8_0:removeEventCb(SettingsVoicePackageController.instance, SettingsEvent.OnChangeSelecetDownloadVoicePack, arg_8_0._updateSelecet, arg_8_0)
end

function var_0_0._onPackItemStateChange(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._mo.lang ~= arg_9_1 then
		return
	end

	arg_9_0:_updateStatus()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	local var_10_0 = luaLang(arg_10_1.nameLangId)
	local var_10_1 = GameConfig:GetDefaultVoiceShortcut()
	local var_10_2 = arg_10_0._mo.lang == var_10_1
	local var_10_3 = HotUpdateVoiceMgr.IsGuoFu and HotUpdateVoiceMgr.ForceSelect[arg_10_0._mo.lang]

	if var_10_2 or var_10_3 then
		var_10_0 = formatLuaLang("voice_package_default", var_10_0)
		arg_10_0._txtname2.alpha = 0.8
	else
		arg_10_0._txtname2.alpha = 1
	end

	arg_10_0._txtname1.text = var_10_0
	arg_10_0._txtname2.text = var_10_0

	local var_10_4 = GameConfig:GetCurVoiceShortcut()

	arg_10_0:_updateSelecet(var_10_4)

	local var_10_5 = var_10_4 == arg_10_0._mo.lang

	gohelper.setActive(arg_10_0._gocur1, var_10_5)
	gohelper.setActive(arg_10_0._gocur2, var_10_5)
	gohelper.setActive(arg_10_0._goNowIcon1, var_10_5)
	gohelper.setActive(arg_10_0._goNowIcon2, var_10_5)
	arg_10_0:_updateStatus()

	if arg_10_0._txtVersion then
		arg_10_0._txtVersion.text = arg_10_0:_getLangCurVersion(arg_10_0._mo.lang, var_10_1)
	end
end

function var_0_0._getLangCurVersion(arg_11_0, arg_11_1, arg_11_2)
	if HotUpdateVoiceMgr.IsGuoFu and arg_11_1 == arg_11_2 then
		arg_11_1 = HotUpdateVoiceMgr.LangZh
	end

	local var_11_0 = SLFramework.GameUpdate.OptionalUpdate.Instance
	local var_11_1 = var_11_0.VoiceBranch
	local var_11_2 = var_11_0:GetLocalVersion(arg_11_1)

	if string.nilorempty(var_11_2) then
		return ""
	end

	return string.format("V.%s.%s", tostring(var_11_1), tostring(var_11_2))
end

function var_0_0._updateStatus(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._mo:getStatus()

	if var_12_0 == SettingsVoicePackageController.NotDownload or var_12_0 == SettingsVoicePackageController.NeedUpdate then
		local var_12_1 = var_12_0 == SettingsVoicePackageController.NeedUpdate and luaLang("voice_package_update_5") or "(%s)"
		local var_12_2, var_12_3, var_12_4 = arg_12_0._mo:getLeftSizeMBorGB()
		local var_12_5 = string.format("%.2f%s", var_12_2, var_12_4)
		local var_12_6 = string.format(var_12_1, var_12_5)

		arg_12_0._txtsize1.text = var_12_6
		arg_12_0._txtsize2.text = var_12_6
	else
		arg_12_0._txtsize1.text = ""
		arg_12_0._txtsize2.text = ""
	end
end

function var_0_0._onClick(arg_13_0)
	SettingsVoicePackageController.instance:dispatchEvent(SettingsEvent.OnChangeSelecetDownloadVoicePack, arg_13_0._mo.lang)
end

function var_0_0._updateSelecet(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 == arg_14_0._mo.lang

	gohelper.setActive(arg_14_0._goselected, var_14_0)
	gohelper.setActive(arg_14_0._gounselected, var_14_0 == false)
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
