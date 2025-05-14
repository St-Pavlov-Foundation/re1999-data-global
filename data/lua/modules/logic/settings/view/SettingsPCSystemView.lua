module("modules.logic.settings.view.SettingsPCSystemView", package.seeall)

local var_0_0 = class("SettingsPCSystemView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_bottom")
	arg_1_0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	arg_1_0._gofullscreenoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_off")
	arg_1_0._gofullscreenon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_on")
	arg_1_0._btnframerateswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch")
	arg_1_0._golowfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	arg_1_0._gohighfps = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	arg_1_0._btnhigh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	arg_1_0._gohighoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	arg_1_0._gohighon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	arg_1_0._gohighrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	arg_1_0._btnmiddle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	arg_1_0._gomiddleoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	arg_1_0._gomiddleon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	arg_1_0._gomiddlerecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	arg_1_0._btnlow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	arg_1_0._golowoff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	arg_1_0._golowon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	arg_1_0._golowrecommend = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch")
	arg_1_0._govideoon = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_on")
	arg_1_0._govideooff = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_off")

	gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	arg_1_0._framerateDrop = gohelper.findChildDropdown(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	arg_1_0._framerateDropClick = gohelper.getClick(arg_1_0._framerateDrop.gameObject)
	arg_1_0._frameTemplate = gohelper.findChild(arg_1_0.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullscreenswitch:AddClickListener(arg_2_0._btnfullscreenswitchOnClick, arg_2_0)
	arg_2_0._btnhigh:AddClickListener(arg_2_0._btnhighOnClick, arg_2_0)
	arg_2_0._btnmiddle:AddClickListener(arg_2_0._btnmiddleOnClick, arg_2_0)
	arg_2_0._btnlow:AddClickListener(arg_2_0._btnlowOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnvideo:AddClickListener(arg_2_0._btnvideoOnClick, arg_2_0)
	arg_2_0._drop:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0._dropClick:AddClickListener(function()
		arg_2_0:_refreshDropdownList()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_2_0)
	arg_2_0._framerateDrop:AddOnValueChanged(arg_2_0._onFrameValueChanged, arg_2_0)
	arg_2_0._framerateDropClick:AddClickListener(function()
		arg_2_0:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, arg_2_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnfullscreenswitch:RemoveClickListener()
	arg_5_0._btnhigh:RemoveClickListener()
	arg_5_0._btnmiddle:RemoveClickListener()
	arg_5_0._btnlow:RemoveClickListener()
	arg_5_0._btnclose:RemoveClickListener()
	arg_5_0._btnvideo:RemoveClickListener()
	arg_5_0._drop:RemoveOnValueChanged()
	arg_5_0._dropClick:RemoveClickListener()
	arg_5_0._framerateDrop:RemoveOnValueChanged()
	arg_5_0._framerateDropClick:RemoveClickListener()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goscreen = gohelper.findChild(arg_6_0.viewGO, "graphicsScroll/Viewport/Content/screen")
	arg_6_0._drop = gohelper.findChildDropdown(arg_6_0.viewGO, "graphicsScroll/Viewport/Content/screen/text/#dropResolution")
	arg_6_0._dropClick = gohelper.getClick(arg_6_0._drop.gameObject)

	arg_6_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_6_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	arg_6_0._resolutionRatioList = SettingsModel.instance:getResolutionRatioStrList()

	arg_6_0:_refreshDropdownList()
	arg_6_0:_refreshTargetFrameRateUI()
	gohelper.setActive(arg_6_0._drop.gameObject, true)
end

function var_0_0._btnfullscreenswitchOnClick(arg_7_0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	arg_7_0:_refreshIsFullScreenUI()
end

function var_0_0._onValueChanged(arg_8_0, arg_8_1)
	if not SettingsModel.instance:setScreenResolutionByIndex(arg_8_1 + 1) then
		arg_8_0._drop:SetValue(arg_8_0._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	arg_8_0:_refreshIsFullScreenUI()

	arg_8_0._preSelectedIndex = arg_8_1
end

function var_0_0._btnvideoOnClick(arg_9_0)
	if SettingsModel.instance:getVideoCompatible() == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			arg_9_0:_switchVideoCompatible()
		end)
	else
		arg_9_0:_switchVideoCompatible()
	end
end

function var_0_0._switchVideoCompatible(arg_11_0)
	local var_11_0 = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(var_11_0 == false)
	arg_11_0:_refreshVideoUI()
end

function var_0_0._btnlowOnClick(arg_12_0)
	arg_12_0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function var_0_0._btnmiddleOnClick(arg_13_0)
	arg_13_0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function var_0_0._btnhighOnClick(arg_14_0)
	arg_14_0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function var_0_0._btncloseOnClick(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._onFrameValueChanged(arg_16_0, arg_16_1)
	SettingsModel.instance:setModelTargetFrameRate(arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function var_0_0._setGraphicsQuality(arg_17_0, arg_17_1)
	if SettingsModel.instance:getModelGraphicsQuality() == arg_17_1 then
		return
	end

	if arg_17_1 < SettingsModel.instance:getRecommendQuality() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			arg_17_0:directSetGraphicsQuality(arg_17_1)
		end)
	else
		arg_17_0:directSetGraphicsQuality(arg_17_1)
	end
end

function var_0_0.directSetGraphicsQuality(arg_19_0, arg_19_1)
	SettingsModel.instance:setGraphicsQuality(arg_19_1)
	arg_19_0:_refreshGraphicsQualityUI()
end

function var_0_0._refreshGraphicsQualityUI(arg_20_0)
	local var_20_0 = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(arg_20_0._golowselected, var_20_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_20_0._gomiddleselected, var_20_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_20_0._gohighselected, var_20_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_20_0._golowon, var_20_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_20_0._golowoff, var_20_0 ~= ModuleEnum.Performance.Low)
	gohelper.setActive(arg_20_0._gomiddleon, var_20_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_20_0._gomiddleoff, var_20_0 ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_20_0._gohighon, var_20_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_20_0._gohighoff, var_20_0 ~= ModuleEnum.Performance.High)
	gohelper.setActive(arg_20_0._goline1, var_20_0 == ModuleEnum.Performance.High)
	gohelper.setActive(arg_20_0._goline2, var_20_0 == ModuleEnum.Performance.Low)
end

function var_0_0._refreshTargetFrameRateUI(arg_21_0)
	local var_21_0 = SettingsModel.instance:getModelTargetFrameRate()

	gohelper.setActive(arg_21_0._golowfps, var_21_0 == ModuleEnum.TargetFrameRate.Low)
	gohelper.setActive(arg_21_0._gohighfps, var_21_0 == ModuleEnum.TargetFrameRate.High)
end

function var_0_0._refreshIsFullScreenUI(arg_22_0)
	gohelper.setActive(arg_22_0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(arg_22_0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function var_0_0._refreshVideoUI(arg_23_0)
	local var_23_0 = SettingsModel.instance:getVideoCompatible()

	gohelper.setActive(arg_23_0._govideoon, var_23_0)
	gohelper.setActive(arg_23_0._govideooff, not var_23_0)
end

function var_0_0.onUpdateParam(arg_24_0)
	return
end

function var_0_0.onOpen(arg_25_0)
	NavigateMgr.instance:addEscape(ViewName.SettingsPCSystemView, arg_25_0._btncloseOnClick, arg_25_0)
	arg_25_0:_refreshUI()

	local var_25_0 = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(arg_25_0._golowrecommend, var_25_0 == ModuleEnum.Performance.Low)
	gohelper.setActive(arg_25_0._gomiddlerecommend, var_25_0 == ModuleEnum.Performance.Middle)
	gohelper.setActive(arg_25_0._gohighrecommend, var_25_0 == ModuleEnum.Performance.High)
end

function var_0_0._refreshUI(arg_26_0)
	arg_26_0:_refreshGraphicsQualityUI()
	arg_26_0:_refreshTargetFrameRateUI()
	arg_26_0:_refreshIsFullScreenUI()
	arg_26_0:_refreshVideoUI()
end

function var_0_0.onClose(arg_27_0)
	if arg_27_0.viewParam and arg_27_0.viewParam.closeCallback then
		arg_27_0.viewParam.closeCallback(arg_27_0.viewParam.closeCallbackObj)
	end

	arg_27_0._simageblur:UnLoadImage()
	arg_27_0._simagetop:UnLoadImage()
	arg_27_0._simagebottom:UnLoadImage()
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

function var_0_0._refreshDropdownList(arg_29_0)
	local var_29_0 = SettingsModel.instance:getResolutionRatioStrList()

	arg_29_0._drop:ClearOptions()
	arg_29_0._drop:AddOptions(var_29_0)
	arg_29_0._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	arg_29_0._preSelectedIndex = arg_29_0._drop:GetValue()
end

function var_0_0._refreshTargetFrameRateUI(arg_30_0)
	local var_30_0 = SettingsModel.instance.FrameRate
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in ipairs(var_30_0) do
		if not BootNativeUtil.isWindows() and iter_30_1 > 60 then
			break
		end

		local var_30_2 = tostring(iter_30_1)

		table.insert(var_30_1, var_30_2)
	end

	arg_30_0._framerateDrop:ClearOptions()
	arg_30_0._framerateDrop:AddOptions(var_30_1)

	local var_30_3 = #var_30_1 * 73

	recthelper.setHeight(arg_30_0._frameTemplate.transform, var_30_3)
	arg_30_0._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	arg_30_0._framerateDropIndex = arg_30_0._framerateDrop:GetValue()

	if arg_30_0._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	local var_30_4 = gohelper.findChild(arg_30_0._framerateDrop.gameObject, "Dropdown List")

	if var_30_4 then
		local var_30_5 = gohelper.findChild(var_30_4, "Viewport/Content")

		if var_30_5 then
			local var_30_6 = var_30_5.transform:GetChild(arg_30_0._framerateDropIndex + 1)

			if var_30_6 then
				local var_30_7 = gohelper.findChild(var_30_6.gameObject, "BG")

				if var_30_7 then
					gohelper.setActive(var_30_7, true)
				end
			end
		end
	end
end

return var_0_0
