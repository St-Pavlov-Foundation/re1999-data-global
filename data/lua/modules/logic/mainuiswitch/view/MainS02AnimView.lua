-- chunkname: @modules/logic/mainuiswitch/view/MainS02AnimView.lua

module("modules.logic.mainuiswitch.view.MainS02AnimView", package.seeall)

local MainS02AnimView = class("MainS02AnimView", MainUIAnimBaseView)

function MainS02AnimView:onInitView()
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "right/go_fight/5/click")

	local animPathList = {
		"right/go_fight",
		"right/#skin_caidan"
	}

	self._anim = self:getUserDataTb_()

	for _, path in ipairs(animPathList) do
		local item = self:getUserDataTb_()

		item.root = gohelper.findChild(self.viewGO, path .. "/5")

		local anim1 = gohelper.findChild(item.root, "5_day")
		local anim2 = gohelper.findChild(item.root, "5_night")

		item.dayAnim = anim1:GetComponent(typeof(UnityEngine.Animator))
		item.nightAnim = anim2:GetComponent(typeof(UnityEngine.Animator))

		table.insert(self._anim, item)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainS02AnimView:addEvents()
	self._click:AddClickListener(self._onclick, self)
	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, self._onWeatherChanged, self)
end

function MainS02AnimView:removeEvents()
	self._click:RemoveClickListener()
	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, self._onWeatherChanged, self)
end

function MainS02AnimView:_onclick()
	if self._isPlayingAnim then
		return
	end

	self:_playAnim("click", 5)
end

function MainS02AnimView:_editableInitView()
	self._animRefreshTime = MainUISwitchConfig.instance:getConstValue(MainUISwitchEnum.ConstId.S02AnimTime, true) or 5
end

function MainS02AnimView:_onRandomPlayAnim()
	if self._isPlayingAnim then
		return
	end

	if MainUISwitchModel.instance:getCurUseUI() ~= self._skinId then
		TaskDispatcher.cancelTask(self._onRandomPlayAnim, self)

		self._isPlayingAnim = false

		return
	end

	local list = {}

	for i = 1, 3 do
		if not self._lastAnimIndex or self._lastAnimIndex ~= i then
			table.insert(list, i)
		end
	end

	local random = math.random(1, #list)

	self._lastAnimIndex = list[random]

	local aniName = "auto" .. self._lastAnimIndex

	self:_playAnim(aniName, 3)
end

function MainS02AnimView:onShow()
	self._isPlayingAnim = false

	self:_onRandomPlayAnim()
end

function MainS02AnimView:_onWeatherChanged()
	TaskDispatcher.cancelTask(self._onEndAnim, self)
	self:_playAnim(self._playAnimName)
end

function MainS02AnimView:_playAnim(name, time)
	TaskDispatcher.cancelTask(self._onRandomPlayAnim, self)

	if string.nilorempty(name) then
		return
	end

	local report = WeatherController.instance:getCurrReport()
	local isNight = report and report.lightMode == WeatherEnum.LightModeNight

	for _, anim in ipairs(self._anim) do
		if isNight then
			anim.nightAnim:Play(name, 0, 0)
		else
			anim.dayAnim:Play(name, 0, 0)
		end

		gohelper.setActive(anim.nightAnim.gameObject, isNight)
		gohelper.setActive(anim.dayAnim.gameObject, not isNight)
	end

	TaskDispatcher.runDelay(self._onEndAnim, self, time or 3)

	self._isPlayingAnim = true
	self._playAnimName = name
end

function MainS02AnimView:_onEndAnim()
	self._isPlayingAnim = false

	TaskDispatcher.runDelay(self._onRandomPlayAnim, self, self._animRefreshTime)
end

function MainS02AnimView:onDestroyView()
	MainS02AnimView.super.onDestroyView(self)
	TaskDispatcher.cancelTask(self._onRandomPlayAnim, self)
	TaskDispatcher.cancelTask(self._onEndAnim, self)
end

return MainS02AnimView
