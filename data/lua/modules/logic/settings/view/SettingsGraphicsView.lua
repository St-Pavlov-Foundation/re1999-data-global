module("modules.logic.settings.view.SettingsGraphicsView", package.seeall)

slot0 = class("SettingsGraphicsView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnlow = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	slot0._golowselected = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/preview/#go_lowselected")
	slot0._golowoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	slot0._golowon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	slot0._golowrecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	slot0._btnmiddle = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	slot0._gomiddleselected = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/preview/#go_middleselected")
	slot0._gomiddleoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	slot0._gomiddleon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	slot0._gomiddlerecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	slot0._btnhigh = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	slot0._gohighselected = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/preview/#go_highselected")
	slot0._gohighoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	slot0._gohighon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	slot0._gohighrecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	slot0._goenergy = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/energymode")
	slot0._btnenergy = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn")
	slot0._goenergyon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/on")
	slot0._goenergyoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/energymode/switch/btn/off")
	slot0._btnvideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn")
	slot0._govideoon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/on")
	slot0._govideooff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/switch/btn/off")
	slot0._videoHD = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/strength")
	slot0._btnHdMode = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn")
	slot0._goHdModeOn = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/on")
	slot0._goHdModeOff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/strength/switch/btn/off")
	slot0._golowfps = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	slot0._gohighfps = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	slot0._goscreen = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen")
	slot0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	slot0._gofullscreenon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_fullscreenon")
	slot0._gofullscreenoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_fullscreenoff")
	slot0._drop = gohelper.findChildDropdown(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/#dropResolution")
	slot0._dropClick = gohelper.getClick(slot0._drop.gameObject)
	slot0._framerateDrop = gohelper.findChildDropdown(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	slot0._framerateDropClick = gohelper.getClick(slot0._framerateDrop.gameObject)
	slot0._frameTemplate = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")
	slot0.verticalmode = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/verticalmode")
	slot0._btnVerticalmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn")
	slot0._goVerticalmodeOn = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/on")
	slot0._goVerticalmodeOff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/verticalmode/switch/btn/off")
	slot0._goscreenshot = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/#go_screenshot")
	slot0._btnshot = gohelper.findChildButtonWithAudio(slot0._goscreenshot, "switch/btn")
	slot0._gooffshot = gohelper.findChild(slot0._goscreenshot, "switch/btn/off")
	slot0._goonshot = gohelper.findChild(slot0._goscreenshot, "switch/btn/on")
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline1")
	slot0._goline2 = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#goline2")

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	slot0._goEnableVido = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo")
	slot0._btnEnableVideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn")
	slot0._goEnableVideoon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn/on")
	slot0._goEnableVideooff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/#go_enableVideo/switch/btn/off")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlow:AddClickListener(slot0._btnlowOnClick, slot0)
	slot0._btnmiddle:AddClickListener(slot0._btnmiddleOnClick, slot0)
	slot0._btnhigh:AddClickListener(slot0._btnhighOnClick, slot0)
	slot0._btnenergy:AddClickListener(slot0._btnenergyOnClick, slot0)
	slot0._btnvideo:AddClickListener(slot0._btnvideoOnClick, slot0)
	slot0._btnHdMode:AddClickListener(slot0._btnvideoHDOnClick, slot0)
	slot0._btnVerticalmode:AddClickListener(slot0._btnVerticalmodeClick, slot0)
	slot0._btnEnableVideo:AddClickListener(slot0._btnEnableVideoOnClick, slot0)

	if BootNativeUtil.isWindows() then
		slot0._btnfullscreenswitch:AddClickListener(slot0._btnfullscreenswitchOnClick, slot0)
		slot0._drop:AddOnValueChanged(slot0._onValueChanged, slot0)
		slot0._dropClick:AddClickListener(function ()
			uv0:_refreshDropdownList()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
		end, slot0)
	end

	slot0._framerateDrop:AddOnValueChanged(slot0._onFrameValueChanged, slot0)
	slot0._framerateDropClick:AddClickListener(function ()
		uv0:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		slot0._btnshot:AddClickListener(slot0._btnShotOnClick, slot0)
	end

	SettingsController.instance:registerCallback(SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
	SettingsController.instance:registerCallback(SettingsEvent.OnChangeHDType, slot0._refreshVideoUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlow:RemoveClickListener()
	slot0._btnmiddle:RemoveClickListener()
	slot0._btnhigh:RemoveClickListener()
	slot0._btnenergy:RemoveClickListener()
	slot0._btnvideo:RemoveClickListener()
	slot0._btnHdMode:RemoveClickListener()
	slot0._btnVerticalmode:RemoveClickListener()
	slot0._btnEnableVideo:RemoveClickListener()

	if BootNativeUtil.isWindows() then
		slot0._btnfullscreenswitch:RemoveClickListener()
		slot0._drop:RemoveOnValueChanged()
		slot0._dropClick:RemoveClickListener()
	end

	slot0._framerateDrop:RemoveOnValueChanged()
	slot0._framerateDropClick:RemoveClickListener()

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		slot0._btnshot:RemoveClickListener()
	end

	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeLangTxt, slot0._onChangeLangTxt, slot0)
	SettingsController.instance:unregisterCallback(SettingsEvent.OnChangeHDType, slot0._refreshVideoUI, slot0)
end

function slot0._btnlowOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function slot0._btnmiddleOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function slot0._btnhighOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function slot0._btnenergyOnClick(slot0)
	SettingsModel.instance:changeEnergyMode()
	slot0:_refreshEnergyUI()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnChangeEnergyMode)
end

function slot0._btnEnableVideoOnClick(slot0)
	slot0:_switchVideoEnable()
end

function slot0._switchVideoEnable(slot0)
	SettingsModel.instance:setVideoEnabled(SettingsModel.instance:getVideoEnabled() == false)
	slot0:_refreshVideoEnabledUI()
end

function slot0._btnvideoOnClick(slot0)
	if SettingsModel.instance:getVideoCompatible() == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:_switchVideoCompatible()
		end)
	else
		slot0:_switchVideoCompatible()
	end
end

function slot0._switchVideoCompatible(slot0)
	SettingsModel.instance:setVideoCompatible(SettingsModel.instance:getVideoCompatible() == false)
	slot0:_refreshVideoUI()
end

function slot0._btnvideoHDOnClick(slot0)
	slot2 = SettingsVoicePackageModel.instance:getPackInfo("res-HD")

	if not SettingsModel.instance:getVideoHDMode() and slot2 and slot2:needDownload() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoHD, MsgBoxEnum.BoxType.Yes_No, function ()
			SettingsVoicePackageController.instance:RequsetVoiceInfo(function ()
				SettingsVoicePackageController.instance:tryDownload(uv0)
			end)
		end)
	else
		slot0:_switchVideoHDMode()
	end
end

function slot0._switchVideoHDMode(slot0)
	SettingsModel.instance:setVideoHDMode(SettingsModel.instance:getVideoHDMode() == false)
	slot0:_refreshVideoUI()
end

function slot0._btnVerticalmodeClick(slot0)
	SettingsModel.instance:setVSyncCount(SettingsModel.instance:getVSyncCount() == 1 and 0 or 1)
	slot0:_refreshVerticalUI()
end

function slot0._btnfullscreenswitchOnClick(slot0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	slot0:_refreshIsFullScreenUI()
end

function slot0._btnShotOnClick(slot0)
	slot1 = not SettingsModel.instance:getScreenshotSwitch()

	SettingsModel.instance:setScreenshotSwitch(slot1)
	slot0:_refreshShotUI()

	if slot1 and BootNativeUtil.isAndroid() then
		SDKMgr.instance:requestReadAndWritePermission()
	end
end

function slot0._onValueChanged(slot0, slot1)
	if not SettingsModel.instance:setScreenResolutionByIndex(slot1 + 1) then
		slot0._drop:SetValue(slot0._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	slot0:_refreshIsFullScreenUI()

	slot0._preSelectedIndex = slot1
end

function slot0._onFrameValueChanged(slot0, slot1)
	SettingsModel.instance:setModelTargetFrameRate(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function slot0._editableInitView(slot0)
	if not SLFramework.FrameworkSettings.IsEditor and BootNativeUtil.isWindows() then
		slot0:_refreshDropdownList()
		gohelper.setActive(slot0._drop.gameObject, true)
		gohelper.setActive(slot0._goscreen.gameObject, true)
		gohelper.setActive(slot0._goenergy.gameObject, false)
	else
		gohelper.setActive(slot0._goscreen.gameObject, false)
	end

	gohelper.setActive(slot0._goEnableVido, BootNativeUtil.isWindows())

	if not GameChannelConfig.isSlsdk() and SDKNativeUtil.isShowShareButton() then
		gohelper.setActive(slot0._goscreenshot, true)
	else
		gohelper.setActive(slot0._goscreenshot, false)
	end

	slot0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() + 1)
	slot0:_refreshVerticalUI()
	gohelper.setActive(slot0.verticalmode, BootNativeUtil.isWindows())
	gohelper.setActive(slot0._videoHD, not VersionValidator.instance:isInReviewing())
end

function slot0._onChangeLangTxt(slot0)
	slot0._drop:ClearOptions()
	slot0:_editableInitView()
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	gohelper.setActive(slot0._golowrecommend, SettingsModel.instance:getRecommendQuality() == ModuleEnum.Performance.Low)
	gohelper.setActive(slot0._gomiddlerecommend, slot1 == ModuleEnum.Performance.Middle)
	gohelper.setActive(slot0._gohighrecommend, slot1 == ModuleEnum.Performance.High)
end

function slot0._refreshUI(slot0)
	slot0:_refreshGraphicsQualityUI()
	slot0:_refreshTargetFrameRateUI()
	slot0:_refreshIsFullScreenUI()
	slot0:_refreshShotUI()
	slot0:_refreshEnergyUI()
	slot0:_refreshVideoUI()
	slot0:_refreshVideoEnabledUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._setGraphicsQuality(slot0, slot1)
	if SettingsModel.instance:getModelGraphicsQuality() == slot1 then
		return
	end

	if slot1 < SettingsModel.instance:getRecommendQuality() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:directSetGraphicsQuality(uv1)
		end)
	else
		slot0:directSetGraphicsQuality(slot1)
	end
end

function slot0.directSetGraphicsQuality(slot0, slot1)
	SettingsModel.instance:setGraphicsQuality(slot1)
	slot0:_refreshGraphicsQualityUI()
end

function slot0._refreshGraphicsQualityUI(slot0)
	gohelper.setActive(slot0._golowselected, SettingsModel.instance:getModelGraphicsQuality() == ModuleEnum.Performance.Low)
	gohelper.setActive(slot0._gomiddleselected, slot1 == ModuleEnum.Performance.Middle)
	gohelper.setActive(slot0._gohighselected, slot1 == ModuleEnum.Performance.High)
	gohelper.setActive(slot0._golowon, slot1 == ModuleEnum.Performance.Low)
	gohelper.setActive(slot0._golowoff, slot1 ~= ModuleEnum.Performance.Low)
	gohelper.setActive(slot0._gomiddleon, slot1 == ModuleEnum.Performance.Middle)
	gohelper.setActive(slot0._gomiddleoff, slot1 ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(slot0._gohighon, slot1 == ModuleEnum.Performance.High)
	gohelper.setActive(slot0._gohighoff, slot1 ~= ModuleEnum.Performance.High)
	gohelper.setActive(slot0._goline1, slot1 == ModuleEnum.Performance.High)
	gohelper.setActive(slot0._goline2, slot1 == ModuleEnum.Performance.Low)
end

function slot0._refreshIsFullScreenUI(slot0)
	gohelper.setActive(slot0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(slot0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function slot0._refreshShotUI(slot0)
	slot1 = SettingsModel.instance:getScreenshotSwitch()

	gohelper.setActive(slot0._gooffshot, not slot1)
	gohelper.setActive(slot0._goonshot, slot1)
end

function slot0._refreshEnergyUI(slot0)
	gohelper.setActive(slot0._goenergyon, SettingsModel.instance:getEnergyMode() == 1)
	gohelper.setActive(slot0._goenergyoff, slot1 == 0)
end

function slot0._refreshVideoUI(slot0)
	slot1 = SettingsModel.instance:getVideoCompatible()
	slot2 = SettingsModel.instance:getVideoHDMode()

	gohelper.setActive(slot0._govideoon, slot1)
	gohelper.setActive(slot0._govideooff, not slot1)
	gohelper.setActive(slot0._goHdModeOn, slot2)
	gohelper.setActive(slot0._goHdModeOff, not slot2)
end

function slot0._refreshVerticalUI(slot0)
	slot1 = UnityEngine.QualitySettings.vSyncCount == 1

	gohelper.setActive(slot0._goVerticalmodeOn, slot1)
	gohelper.setActive(slot0._goVerticalmodeOff, not slot1)
end

function slot0._refreshVideoEnabledUI(slot0)
	slot1 = SettingsModel.instance:getVideoEnabled()

	gohelper.setActive(slot0._goEnableVideoon, slot1)
	gohelper.setActive(slot0._goEnableVideooff, not slot1)
end

function slot0._refreshVerticalUI(slot0)
	slot1 = SettingsModel.instance:getVSyncCount() == 1

	gohelper.setActive(slot0._goVerticalmodeOn, slot1)
	gohelper.setActive(slot0._goVerticalmodeOff, not slot1)
end

function slot0._refreshDropdownList(slot0)
	slot0._drop:ClearOptions()
	slot0._drop:AddOptions(SettingsModel.instance:getResolutionRatioStrList())
	slot0._drop:SetValue(SettingsModel.instance:getCurrentDropDownIndex())

	slot0._preSelectedIndex = slot0._drop:GetValue()
end

function slot0._refreshDropdownList(slot0)
	slot0._drop:ClearOptions()
	slot0._drop:AddOptions(SettingsModel.instance:getResolutionRatioStrList())
	slot0._drop:SetValue(SettingsModel.instance:getCurrentDropDownIndex())

	slot0._preSelectedIndex = slot0._drop:GetValue()
end

function slot0._refreshTargetFrameRateUI(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(SettingsModel.instance.FrameRate) do
		if not BootNativeUtil.isWindows() and slot7 > 60 then
			break
		end

		table.insert(slot2, tostring(slot7))
	end

	slot0._framerateDrop:ClearOptions()
	slot0._framerateDrop:AddOptions(slot2)
	recthelper.setHeight(slot0._frameTemplate.transform, #slot2 * 73)
	slot0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	slot0._framerateDropIndex = slot0._framerateDrop:GetValue()

	if slot0._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	if gohelper.findChild(slot0._framerateDrop.gameObject, "Dropdown List") and gohelper.findChild(slot4, "Viewport/Content") and slot5.transform:GetChild(slot0._framerateDropIndex + 1) and gohelper.findChild(slot6.gameObject, "BG") then
		gohelper.setActive(slot7, true)
	end
end

return slot0
