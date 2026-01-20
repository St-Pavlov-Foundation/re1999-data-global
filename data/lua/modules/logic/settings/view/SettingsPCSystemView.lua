-- chunkname: @modules/logic/settings/view/SettingsPCSystemView.lua

module("modules.logic.settings.view.SettingsPCSystemView", package.seeall)

local SettingsPCSystemView = class("SettingsPCSystemView", BaseView)

function SettingsPCSystemView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "simage_blur")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/simage_bottom")
	self._btnfullscreenswitch = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch")
	self._gofullscreenoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_off")
	self._gofullscreenon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text/#btn_fullscreenswitch/#go_on")
	self._btnframerateswitch = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch")
	self._golowfps = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_lowfps")
	self._gohighfps = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/#btn_framerateswitch/#go_highfps")
	self._btnhigh = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high")
	self._gohighoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highoff")
	self._gohighon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highon")
	self._gohighrecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_high/#go_highrecommend")
	self._btnmiddle = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle")
	self._gomiddleoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleoff")
	self._gomiddleon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middleon")
	self._gomiddlerecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_middle/#go_middlerecommend")
	self._btnlow = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low")
	self._golowoff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowoff")
	self._golowon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowon")
	self._golowrecommend = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/imagequality/graphics/#btn_low/#go_lowrecommend")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnvideo = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch")
	self._govideoon = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_on")
	self._govideooff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/videomode/#btn_videoswitch/#go_off")

	gohelper.setActive(gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen/fullscreen/text"), false)

	self._framerateDrop = gohelper.findChildDropdown(self.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch")
	self._framerateDropClick = gohelper.getClick(self._framerateDrop.gameObject)
	self._frameTemplate = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/framerate/dropframerateswitch/Template")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsPCSystemView:addEvents()
	self._btnfullscreenswitch:AddClickListener(self._btnfullscreenswitchOnClick, self)
	self._btnhigh:AddClickListener(self._btnhighOnClick, self)
	self._btnmiddle:AddClickListener(self._btnmiddleOnClick, self)
	self._btnlow:AddClickListener(self._btnlowOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnvideo:AddClickListener(self._btnvideoOnClick, self)
	self._drop:AddOnValueChanged(self._onValueChanged, self)
	self._dropClick:AddClickListener(function()
		self:_refreshDropdownList()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)
	self._framerateDrop:AddOnValueChanged(self._onFrameValueChanged, self)
	self._framerateDropClick:AddClickListener(function()
		self:_refreshTargetFrameRateUI()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)
end

function SettingsPCSystemView:removeEvents()
	self._btnfullscreenswitch:RemoveClickListener()
	self._btnhigh:RemoveClickListener()
	self._btnmiddle:RemoveClickListener()
	self._btnlow:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnvideo:RemoveClickListener()
	self._drop:RemoveOnValueChanged()
	self._dropClick:RemoveClickListener()
	self._framerateDrop:RemoveOnValueChanged()
	self._framerateDropClick:RemoveClickListener()
end

function SettingsPCSystemView:_editableInitView()
	self._goscreen = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/screen")
	self._drop = gohelper.findChildDropdown(self.viewGO, "graphicsScroll/Viewport/Content/screen/text/#dropResolution")
	self._dropClick = gohelper.getClick(self._drop.gameObject)

	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))

	self._resolutionRatioList = SettingsModel.instance:getResolutionRatioStrList()

	self:_refreshDropdownList()
	self:_refreshTargetFrameRateUI()
	gohelper.setActive(self._drop.gameObject, true)
end

function SettingsPCSystemView:_btnfullscreenswitchOnClick()
	if SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On then
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.Off)
	else
		SettingsModel.instance:setFullChange(ModuleEnum.FullScreenState.On)
	end

	self:_refreshIsFullScreenUI()
end

function SettingsPCSystemView:_onValueChanged(index)
	if not SettingsModel.instance:setScreenResolutionByIndex(index + 1) then
		self._drop:SetValue(self._preSelectedIndex)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
	self:_refreshIsFullScreenUI()

	self._preSelectedIndex = index
end

function SettingsPCSystemView:_btnvideoOnClick()
	local compatible = SettingsModel.instance:getVideoCompatible()

	if compatible == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.SettingVideoCompatible, MsgBoxEnum.BoxType.Yes_No, function()
			self:_switchVideoCompatible()
		end)
	else
		self:_switchVideoCompatible()
	end
end

function SettingsPCSystemView:_switchVideoCompatible()
	local compatible = SettingsModel.instance:getVideoCompatible()

	SettingsModel.instance:setVideoCompatible(compatible == false)
	self:_refreshVideoUI()
end

function SettingsPCSystemView:_btnlowOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.Low)
end

function SettingsPCSystemView:_btnmiddleOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.Middle)
end

function SettingsPCSystemView:_btnhighOnClick()
	self:_setGraphicsQuality(ModuleEnum.Performance.High)
end

function SettingsPCSystemView:_btncloseOnClick()
	self:closeThis()
end

function SettingsPCSystemView:_onFrameValueChanged(index)
	SettingsModel.instance:setModelTargetFrameRate(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_select)
end

function SettingsPCSystemView:_setGraphicsQuality(quality)
	local currentQuality = SettingsModel.instance:getModelGraphicsQuality()

	if currentQuality == quality then
		return
	end

	local recommendQuality = SettingsModel.instance:getRecommendQuality()

	if quality < recommendQuality then
		GameFacade.showMessageBox(MessageBoxIdDefine.SwitchHigherQuality, MsgBoxEnum.BoxType.Yes_No, function()
			self:directSetGraphicsQuality(quality)
		end)
	else
		self:directSetGraphicsQuality(quality)
	end
end

function SettingsPCSystemView:directSetGraphicsQuality(quality)
	SettingsModel.instance:setGraphicsQuality(quality)
	self:_refreshGraphicsQualityUI()
end

function SettingsPCSystemView:_refreshGraphicsQualityUI()
	local quality = SettingsModel.instance:getModelGraphicsQuality()

	gohelper.setActive(self._golowselected, quality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddleselected, quality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighselected, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._golowon, quality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._golowoff, quality ~= ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddleon, quality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gomiddleoff, quality ~= ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighon, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._gohighoff, quality ~= ModuleEnum.Performance.High)
	gohelper.setActive(self._goline1, quality == ModuleEnum.Performance.High)
	gohelper.setActive(self._goline2, quality == ModuleEnum.Performance.Low)
end

function SettingsPCSystemView:_refreshTargetFrameRateUI()
	local targetFrameRate = SettingsModel.instance:getModelTargetFrameRate()

	gohelper.setActive(self._golowfps, targetFrameRate == ModuleEnum.TargetFrameRate.Low)
	gohelper.setActive(self._gohighfps, targetFrameRate == ModuleEnum.TargetFrameRate.High)
end

function SettingsPCSystemView:_refreshIsFullScreenUI()
	gohelper.setActive(self._gofullscreenon, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.On)
	gohelper.setActive(self._gofullscreenoff, SettingsModel.instance._isFullScreen == ModuleEnum.FullScreenState.Off)
end

function SettingsPCSystemView:_refreshVideoUI()
	local compatible = SettingsModel.instance:getVideoCompatible()

	gohelper.setActive(self._govideoon, compatible)
	gohelper.setActive(self._govideooff, not compatible)
end

function SettingsPCSystemView:onUpdateParam()
	return
end

function SettingsPCSystemView:onOpen()
	NavigateMgr.instance:addEscape(ViewName.SettingsPCSystemView, self._btncloseOnClick, self)
	self:_refreshUI()

	local recommendQuality = SettingsModel.instance:getRecommendQuality()

	gohelper.setActive(self._golowrecommend, recommendQuality == ModuleEnum.Performance.Low)
	gohelper.setActive(self._gomiddlerecommend, recommendQuality == ModuleEnum.Performance.Middle)
	gohelper.setActive(self._gohighrecommend, recommendQuality == ModuleEnum.Performance.High)
end

function SettingsPCSystemView:_refreshUI()
	self:_refreshGraphicsQualityUI()
	self:_refreshTargetFrameRateUI()
	self:_refreshIsFullScreenUI()
	self:_refreshVideoUI()
end

function SettingsPCSystemView:onClose()
	if self.viewParam and self.viewParam.closeCallback then
		self.viewParam.closeCallback(self.viewParam.closeCallbackObj)
	end

	self._simageblur:UnLoadImage()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

function SettingsPCSystemView:onDestroyView()
	return
end

function SettingsPCSystemView:_refreshDropdownList()
	local strList = SettingsModel.instance:getResolutionRatioStrList()

	self._drop:ClearOptions()
	self._drop:AddOptions(strList)
	self._drop:SetValue((SettingsModel.instance:getCurrentDropDownIndex()))

	self._preSelectedIndex = self._drop:GetValue()
end

function SettingsPCSystemView:_refreshTargetFrameRateUI()
	local frames = SettingsModel.instance.FrameRate
	local list = {}

	for _, v in ipairs(frames) do
		if not BootNativeUtil.isWindows() and v > 60 then
			break
		end

		local str = tostring(v)

		table.insert(list, str)
	end

	self._framerateDrop:ClearOptions()
	self._framerateDrop:AddOptions(list)

	local contentHeight = #list * 73

	recthelper.setHeight(self._frameTemplate.transform, contentHeight)
	self._framerateDrop:SetValue(SettingsModel.instance:getCurrentFrameRateIndex() - 1)

	self._framerateDropIndex = self._framerateDrop:GetValue()

	if self._framerateDropIndex == 0 then
		SettingsModel.instance:setModelTargetFrameRate(0)
	end

	local list = gohelper.findChild(self._framerateDrop.gameObject, "Dropdown List")

	if list then
		local content = gohelper.findChild(list, "Viewport/Content")

		if content then
			local item = content.transform:GetChild(self._framerateDropIndex + 1)

			if item then
				local bg = gohelper.findChild(item.gameObject, "BG")

				if bg then
					gohelper.setActive(bg, true)
				end
			end
		end
	end
end

return SettingsPCSystemView
