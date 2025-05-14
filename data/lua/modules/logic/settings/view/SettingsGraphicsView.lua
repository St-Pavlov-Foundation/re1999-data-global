module("modules.logic.settings.view.SettingsGraphicsView", package.seeall)

local var_0_0 = class("SettingsGraphicsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnlow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	arg_1_0._golowselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/preview/#go_lowselected")
	arg_1_0._golowoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	arg_1_0._golowon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	arg_1_0._golowrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	arg_1_0._btnmiddle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	arg_1_0._gomiddleselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/preview/#go_middleselected")
	arg_1_0._gomiddleoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	arg_1_0._gomiddleon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	arg_1_0._gomiddlerecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	arg_1_0._btnhigh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	arg_1_0._gohighselected = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/preview/#go_highselected")
	arg_1_0._gohighoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	arg_1_0._gohighon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	arg_1_0._gohighrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	arg_1_0._goenergy = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode")
	arg_1_0._btnenergy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn")
	arg_1_0._goenergyon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/on")
	arg_1_0._goenergyoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/off")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn")
	arg_1_0._govideoon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/on")
	arg_1_0._govideooff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/off")
	arg_1_0._videoHD = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength")
	arg_1_0._btnHdMode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn")
	arg_1_0._goHdModeOn = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/on")
	arg_1_0._goHdModeOff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/off")
	arg_1_0._golowfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	arg_1_0._gohighfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	arg_1_0._goscreen = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen")
	arg_1_0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	arg_1_0._gofullscreenon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_fullscreenon")
	arg_1_0._gofullscreenoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_fullscreenoff")
	arg_1_0._drop = gohelper.findChildDropdown(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/#dropResolution")
	arg_1_0._dropClick = gohelper.getClick(arg_1_0._drop.gameObject)
	arg_1_0._framerateDrop = gohelper.findChildDropdown(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	arg_1_0._framerateDropClick = gohelper.getClick(arg_1_0._framerateDrop.gameObject)
	arg_1_0._frameTemplate = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")
	arg_1_0.verticalmode = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode")
	arg_1_0._btnVerticalmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn")
	arg_1_0._goVerticalmodeOn = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/on")
	arg_1_0._goVerticalmodeOff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/off")
	arg_1_0._goscreenshot = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_screenshot")
	arg_1_0._btnshot = gohelper.findChildButtonWithAudio(arg_1_0._goscreenshot, "switch/btn")
	arg_1_0._gooffshot = gohelper.findChild(arg_1_0._goscreenshot, "switch/btn/off")
	arg_1_0._goonshot = gohelper.findChild(arg_1_0._goscreenshot, "switch/btn/on")
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline2")

	gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	arg_1_0._goEnableVido = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo")
	arg_1_0._btnEnableVideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn")
	arg_1_0._goEnableVideoon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn/on")
	arg_1_0._goEnableVideooff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn/off")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlow:AddClickListener(arg_2_0._btnlowOnClick, arg_2_0)
	arg_2_0._btnmiddle:AddClickListener(arg_2_0._btnmiddleOnClick, arg_2_0)
	arg_2_0._btnhigh:AddClickListener(arg_2_0._btnhighOnClick, arg_2_0)
	arg_2_0._btnenergy:AddClickListener(arg_2_0._btnenergyOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._btnHdMode:AddClickListener(arg_2_0._btnvideoHDOnClick, arg_2_0)
	arg_2_0._btnVerticalmode:AddClickListener(arg_2_0._btnVerticalmodeClick, arg_2_0)
	arg_2_0._btnEnableVideo:AddClickListener(arg_2_0._btnEnableVideoOnClick, arg_2_0)

	if BootNativeUtil.isWindows() then
		arg_2_0._btnfullscreenswitch:AddClickListener(arg_2_0._btnfullscreenswitchOnClick, arg_2_0)
		arg_2_0._drop:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
		arg_2_0._dropClick:AddClickListener(function()
			arg_2_0:_refreshDropdownList()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, arg_2_0)
	end

	arg_2_0._framerateDrop:AddOnValueChanged(arg_2_0._onFrameValueChanged, arg_2_0)
	arg_2_0._framerateDropClick:AddClickListener(function()
		arg_2_0:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_2_0)

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		arg_2_0._btnshot:AddClickListener(arg_2_0._btnShotOnClick, arg_2_0)
	end

	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, arg_2_0._onChangeLangTxt, arg_2_0)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeHDType, arg_2_0._refreshVideoUI, arg_2_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnlow:RemoveClickListener()
	arg_5_0._btnmiddle:RemoveClickListener()
	arg_5_0._btnhigh:RemoveClickListener()
	arg_5_0._btnenergy:RemoveClickListener()
	arg_5_0._btnvideo:RemoveClickListener()
	arg_5_0._btnHdMode:RemoveClickListener()
	arg_5_0._btnVerticalmode:RemoveClickListener()
	arg_5_0._btnEnableVideo:RemoveClickListener()

	if BootNativeUtil.isWindows() then
		arg_5_0._btnfullscreenswitch:RemoveClickListener()
		arg_5_0._drop:RemoveOnValueChanged()
		arg_5_0._dropClick:RemoveClickListener()
	end

	arg_5_0._framerateDrop:RemoveOnValueChanged()
	arg_5_0._framerateDropClick:RemoveClickListener()

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		arg_5_0._btnshot:RemoveClickListener()
	end

	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, arg_5_0._onChangeLangTxt, arg_5_0)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeHDType, arg_5_0._refreshVideoUI, arg_5_0)
end

function var_0_0._btnlowOnClick(arg_6_0)
	arg_6_0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function var_0_0._btnmiddleOnClick(arg_7_0)
	arg_7_0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function var_0_0._btnhighOnClick(arg_8_0)
	arg_8_0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function var_0_0._btnenergyOnClick(arg_9_0)
	SettingsModel.instance:changeEnergyMode()
	arg_9_0:_refreshEnergyUI()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeEnergyMode)
end

function var_0_0._btnEnableVideoOnClick(arg_10_0)
	arg_10_0:_switchVideoEnable()
end

function var_0_0._switchVideoEnable(arg_11_0)
	local var_11_0 = SettingsModel.instance:getVideoEnabled()

	SettingsModel.instance:setVideoEnabled(var_11_0 == false)
	arg_11_0:_refreshVideoEnabledUI()
end

function var_0_0._btnvideoOnClick(arg_12_0)
	if SettingsModel.instance:getVideoCompatible() == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			arg_12_0:_switchVideoCompatible()
		end)
	else
		arg_12_0:_switchVideoCompatible()
	end
end

function var_0_0._switchVideoCompatible(arg_14_0)
	local var_14_0 = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(var_14_0 == false)
	arg_14_0:_refreshVideoUI()
end

function var_0_0._btnvideoHDOnClick(arg_15_0)
	local var_15_0 = SettingsModel.instance:getVideoHDMode()
	local var_15_1 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if not var_15_0 and var_15_1 and var_15_1:needDownload() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoHD, MsgBoxEnum.BoxType.Yes_No, function()
			SettingsVoicePackageController.instance:RequsetVoiceInfo(function()
				SettingsVoicePackageController.instance:tryDownload(var_15_1)
			end)
		end)
	else
		arg_15_0:_switchVideoHDMode()
	end
end

function var_0_0._switchVideoHDMode(arg_18_0)
	local var_18_0 = SettingsModel.instance:getVideoHDMode()

	SettingsModel.instance:setVideoHDMode(var_18_0 == false)
	arg_18_0:_refreshVideoUI()
end

function var_0_0._btnVerticalmodeClick(arg_19_0)
	local var_19_0 = SettingsModel.instance:getVSyncCount() == 1

	SettingsModel.instance:setVSyncCount(var_19_0 and 0 or 1)
	arg_19_0:_refreshVerticalUI()
end

function var_0_0._btnfullscreenswitchOnClick(arg_20_0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	arg_20_0:_refreshIsFullScreenUI()
end

function var_0_0._btnShotOnClick(arg_21_0)
	local var_21_0 = not SettingsModel.instance:getScreenshotSwitch()

	SettingsModel.instance:setScreenshotSwitch(var_21_0)
	arg_21_0:_refreshShotUI()

	if var_21_0 and BootNativeUtil.isAndroid() then
		SDKMgr.instance:requestReadAndWritePermission()
	end
end

function var_0_0._onValueChanged(arg_22_0, arg_22_1)
	if not SettingsModel.instance:setScreenResolutionByIndex(arg_22_1 + 1) then
		arg_22_0._drop:SetValue(arg_22_0._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	arg_22_0:_refreshIsFullScreenUI()

	arg_22_0._preSelectedIndex = arg_22_1
end

function var_0_0._onFrameValueChanged(arg_23_0, arg_23_1)
	SettingsModel.instance:setModelTargetFrameRate(arg_23_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function var_0_0._editableInitView(arg_24_0)
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		arg_24_0:_refreshDropdownList()
		gohelper.setActive(arg_24_0._drop.gameObject, true)
		gohelper.setActive(arg_24_0._goscreen.gameObject, true)
		gohelper.setActive(arg_24_0._goenergy.gameObject, false)
	else
		gohelper.setActive(arg_24_0._goscreen.gameObject, false)
	end

	gohelper.setActive(arg_24_0._goEnableVido, BootNativeUtil.isWindows())

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		gohelper.setActive(arg_24_0._goscreenshot, true)
	else
		gohelper.setActive(arg_24_0._goscreenshot, false)
	end

	arg_24_0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() + 1)
	arg_24_0:_refreshVerticalUI()
	gohelper.setActive(arg_24_0.verticalmode, BootNativeUtil.isWindows())
	gohelper.setActive(arg_24_0._videoHD, not VersionValidator.instance:isInReviewing())
end

function var_0_0._onChangeLangTxt(arg_25_0)
	arg_25_0._drop:ClearOptions()
	arg_25_0:_editableInitView()
end

function var_0_0.onUpdateParam(arg_26_0)
	arg_26_0:_refreshUI()
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0:_refreshUI()

	local var_27_0 = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(arg_27_0._golowrecommend, var_27_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_27_0._gomiddlerecommend, var_27_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_27_0._gohighrecommend, var_27_0 == ModuleEnum.Performance.High)
end

function var_0_0._refreshUI(arg_28_0)
	arg_28_0:_refreshGraphicsQualityUI()
	arg_28_0:_refreshTargetFrameRateUI()
	arg_28_0:_refreshIsFullScreenUI()
	arg_28_0:_refreshShotUI()
	arg_28_0:_refreshEnergyUI()
	arg_28_0:_refreshVideoUI()
	arg_28_0:_refreshVideoEnabledUI()
end

function var_0_0.onClose(arg_29_0)
	return
end

function var_0_0.onDestroyView(arg_30_0)
	return
end

function var_0_0._setGraphicsQuality(arg_31_0, arg_31_1)
	if SettingsModel.instance:getModelGraphicsQuality() == arg_31_1 then
		return
	end

	if arg_31_1 < SettingsModel.instance:getRecommendQuality() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			arg_31_0:directSetGraphicsQuality(arg_31_1)
		end)
	else
		arg_31_0:directSetGraphicsQuality(arg_31_1)
	end
end

function var_0_0.directSetGraphicsQuality(arg_33_0, arg_33_1)
	SettingsModel.instance:setGraphicsQuality(arg_33_1)
	arg_33_0:_refreshGraphicsQualityUI()
end

function var_0_0._refreshGraphicsQualityUI(arg_34_0)
	local var_34_0 = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(arg_34_0._golowselected, var_34_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_34_0._gomiddleselected, var_34_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_34_0._gohighselected, var_34_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_34_0._golowon, var_34_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_34_0._golowoff, var_34_0 ~= ModuleEnum.Performance.Low)
	gohelper.setActive(arg_34_0._gomiddleon, var_34_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_34_0._gomiddleoff, var_34_0 ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_34_0._gohighon, var_34_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_34_0._gohighoff, var_34_0 ~= ModuleEnum.Performance.High)
	gohelper.setActive(arg_34_0._goline1, var_34_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_34_0._goline2, var_34_0 == ModuleEnum.Performance.Low)
end

function var_0_0._refreshIsFullScreenUI(arg_35_0)
	gohelper.setActive(arg_35_0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(arg_35_0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function var_0_0._refreshShotUI(arg_36_0)
	local var_36_0 = SettingsModel.instance:getScreenshotSwitch()

	gohelper.setActive(arg_36_0._gooffshot, not var_36_0)
	gohelper.setActive(arg_36_0._goonshot, var_36_0)
end

function var_0_0._refreshEnergyUI(arg_37_0)
	local var_37_0 = SettingsModel.instance:getEnergyMode()

	gohelper.setActive(arg_37_0._goenergyon, var_37_0 == 1)
	gohelper.setActive(arg_37_0._goenergyoff, var_37_0 == 0)
end

function var_0_0._refreshVideoUI(arg_38_0)
	local var_38_0 = SettingsModel.instance:getVideoCompatible()
	local var_38_1 = SettingsModel.instance:getVideoHDMode()

	gohelper.setActive(arg_38_0._govideoon, var_38_0)
	gohelper.setActive(arg_38_0._govideooff, not var_38_0)
	gohelper.setActive(arg_38_0._goHdModeOn, var_38_1)
	gohelper.setActive(arg_38_0._goHdModeOff, not var_38_1)
end

function var_0_0._refreshVerticalUI(arg_39_0)
	local var_39_0 = UnityEngine.QualitySettings.vSyncCount == 1

	gohelper.setActive(arg_39_0._goVerticalmodeOn, var_39_0)
	gohelper.setActive(arg_39_0._goVerticalmodeOff, not var_39_0)
end

function var_0_0._refreshVideoEnabledUI(arg_40_0)
	local var_40_0 = SettingsModel.instance:getVideoEnabled()

	gohelper.setActive(arg_40_0._goEnableVideoon, var_40_0)
	gohelper.setActive(arg_40_0._goEnableVideooff, not var_40_0)
end

function var_0_0._refreshVerticalUI(arg_41_0)
	local var_41_0 = SettingsModel.instance:getVSyncCount() == 1

	gohelper.setActive(arg_41_0._goVerticalmodeOn, var_41_0)
	gohelper.setActive(arg_41_0._goVerticalmodeOff, not var_41_0)
end

function var_0_0._refreshDropdownList(arg_42_0)
	local var_42_0 = SettingsModel.instance:getResolutionRatioStrList()

	arg_42_0._drop:ClearOptions()
	arg_42_0._drop:AddOptions(var_42_0)
	arg_42_0._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	arg_42_0._preSelectedIndex = arg_42_0._drop:GetValue()
end

function var_0_0._refreshDropdownList(arg_43_0)
	local var_43_0 = SettingsModel.instance:getResolutionRatioStrList()

	arg_43_0._drop:ClearOptions()
	arg_43_0._drop:AddOptions(var_43_0)
	arg_43_0._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	arg_43_0._preSelectedIndex = arg_43_0._drop:GetValue()
end

function var_0_0._refreshTargetFrameRateUI(arg_44_0)
	local var_44_0 = SettingsModel.instance.FrameRate
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		if not BootNativeUtil.isWindows() and iter_44_1 > 60 then
			break
		end

		local var_44_2 = tostring(iter_44_1)

		table.insert(var_44_1, var_44_2)
	end

	arg_44_0._framerateDrop:ClearOptions()
	arg_44_0._framerateDrop:AddOptions(var_44_1)

	local var_44_3 = #var_44_1 * 73

	recthelper.setHeight(arg_44_0._frameTemplate.transform, var_44_3)
	arg_44_0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	arg_44_0._framerateDropIndex = arg_44_0._framerateDrop:GetValue()

	if arg_44_0._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	local var_44_4 = gohelper.findChild(arg_44_0._framerateDrop.gameObject, "Dropdown List")

	if var_44_4 then
		local var_44_5 = gohelper.findChild(var_44_4, "Viewport/Content")

		if var_44_5 then
			local var_44_6 = var_44_5.transform:GetChild(arg_44_0._framerateDropIndex + 1)

			if var_44_6 then
				local var_44_7 = gohelper.findChild(var_44_6.gameObject, "BG")

				if var_44_7 then
					gohelper.setActive(var_44_7, true)
				end
			end
		end
	end
end

return var_0_0
