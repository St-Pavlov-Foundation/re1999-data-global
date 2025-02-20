module("modules.logic.settings.view.SettingsPCSystemView", package.seeall)

slot0 = class("SettingsPCSystemView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "simage_blur")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/simage_bottom")
	slot0._btnfullscreenswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	slot0._gofullscreenoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_off")
	slot0._gofullscreenon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_on")
	slot0._btnframerateswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch")
	slot0._golowfps = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	slot0._gohighfps = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	slot0._btnhigh = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	slot0._gohighoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	slot0._gohighon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	slot0._gohighrecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	slot0._btnmiddle = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	slot0._gomiddleoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	slot0._gomiddleon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	slot0._gomiddlerecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	slot0._btnlow = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	slot0._golowoff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	slot0._golowon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	slot0._golowrecommend = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnvideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch")
	slot0._govideoon = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_on")
	slot0._govideooff = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_off")

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfullscreenswitch:AddClickListener(slot0._btnfullscreenswitchOnClick, slot0)
	slot0._btnframerateswitch:AddClickListener(slot0._btnframerateswitchOnClick, slot0)
	slot0._btnhigh:AddClickListener(slot0._btnhighOnClick, slot0)
	slot0._btnmiddle:AddClickListener(slot0._btnmiddleOnClick, slot0)
	slot0._btnlow:AddClickListener(slot0._btnlowOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnvideo:AddClickListener(slot0._btnvideoOnClick, slot0)
	slot0._drop:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0._dropClick:AddClickListener(function ()
		uv0:_refreshDropdownList()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfullscreenswitch:RemoveClickListener()
	slot0._btnframerateswitch:RemoveClickListener()
	slot0._btnhigh:RemoveClickListener()
	slot0._btnmiddle:RemoveClickListener()
	slot0._btnlow:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnvideo:RemoveClickListener()
	slot0._drop:RemoveOnValueChanged()
	slot0._dropClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._goscreen = gohelper.findChild(slot0.viewGO, "graphicsScroll/Viewport/Content/screen")
	slot0._drop = gohelper.findChildDropdown(slot0.viewGO, "graphicsScroll/Viewport/Content/screen/text/#dropResolution")
	slot0._dropClick = gohelper.getClick(slot0._drop.gameObject)

	slot0._simageblur:LoadImage(ResUrl.getCommonIcon("full/bj_zase_tongyong"))
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	slot0._resolutionRatioList = SettingsModel.instance:getResolutionRatioStrList()

	slot0:_refreshDropdownList()
	gohelper.setActive(slot0._drop.gameObject, true)
end

function slot0._btnfullscreenswitchOnClick(slot0)
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	slot0:_refreshIsFullScreenUI()
end

function slot0._btnframerateswitchOnClick(slot0)
	if SettingsModel.instance:getModelTargetFrameRate() == ModuleEnum.TargetFrameRate.Low then
		slot1 = ModuleEnum.TargetFrameRate.High
	elseif slot1 == ModuleEnum.TargetFrameRate.High then
		slot1 = ModuleEnum.TargetFrameRate.Low
	end

	SettingsModel.instance:setTargetFrameRate(slot1)
	slot0:_refreshTargetFrameRateUI()
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

function slot0._btnlowOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function slot0._btnmiddleOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function slot0._btnhighOnClick(slot0)
	slot0:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
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

function slot0._refreshTargetFrameRateUI(slot0)
	gohelper.setActive(slot0._golowfps, SettingsModel.instance:getModelTargetFrameRate() == ModuleEnum.TargetFrameRate.Low)
	gohelper.setActive(slot0._gohighfps, slot1 == ModuleEnum.TargetFrameRate.High)
end

function slot0._refreshIsFullScreenUI(slot0)
	gohelper.setActive(slot0._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(slot0._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function slot0._refreshVideoUI(slot0)
	slot1 = SettingsModel.instance:getVideoCompatible()

	gohelper.setActive(slot0._govideoon, slot1)
	gohelper.setActive(slot0._govideooff, not slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.SettingsPCSystemView, slot0._btncloseOnClick, slot0)
	slot0:_refreshUI()
	gohelper.setActive(slot0._golowrecommend, SettingsModel.instance:getRecommendQuality() == ModuleEnum.Performance.Low)
	gohelper.setActive(slot0._gomiddlerecommend, slot1 == ModuleEnum.Performance.Middle)
	gohelper.setActive(slot0._gohighrecommend, slot1 == ModuleEnum.Performance.High)
end

function slot0._refreshUI(slot0)
	slot0:_refreshGraphicsQualityUI()
	slot0:_refreshTargetFrameRateUI()
	slot0:_refreshIsFullScreenUI()
	slot0:_refreshVideoUI()
end

function slot0.onClose(slot0)
	if slot0.viewParam and slot0.viewParam.closeCallback then
		slot0.viewParam.closeCallback(slot0.viewParam.closeCallbackObj)
	end

	slot0._simageblur:UnLoadImage()
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshDropdownList(slot0)
	slot0._drop:ClearOptions()
	slot0._drop:AddOptions(SettingsModel.instance:getResolutionRatioStrList())
	slot0._drop:SetValue(SettingsModel.instance:getCurrentDropDownIndex())

	slot0._preSelectedIndex = slot0._drop:GetValue()
end

return slot0
