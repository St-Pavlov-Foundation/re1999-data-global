-- chunkname: @modules/logic/settings/model/SettingsLimitedRoleMO.lua

module("modules.logic.settings.model.SettingsLimitedRoleMO", package.seeall)

local SettingsLimitedRoleMO = class("SettingsLimitedRoleMO")
local ToggleValue1Auto = 0
local ToggleValue1Manual = 1
local ToggleValue2EveryLogin = 0
local ToggleValue2Daily = 1

function SettingsLimitedRoleMO:ctor()
	self._toggleValue1 = nil
	self._toggleValue2 = nil
end

function SettingsLimitedRoleMO:reInit()
	self._toggleValue1 = nil
	self._toggleValue2 = nil
end

function SettingsLimitedRoleMO:_checkReadLocalValue()
	if not self._toggleValue1 then
		self._toggleValue1 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, ToggleValue1Auto)
	end

	if not self._toggleValue2 then
		self._toggleValue2 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, ToggleValue2EveryLogin)
	end
end

function SettingsLimitedRoleMO:isAuto()
	self:_checkReadLocalValue()

	return self._toggleValue1 == ToggleValue1Auto
end

function SettingsLimitedRoleMO:isEveryLogin()
	self:_checkReadLocalValue()

	return self._toggleValue2 == ToggleValue2EveryLogin
end

function SettingsLimitedRoleMO:isDaily()
	self:_checkReadLocalValue()

	return self._toggleValue2 == ToggleValue2Daily
end

function SettingsLimitedRoleMO:setAuto()
	self._toggleValue1 = ToggleValue1Auto

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, self._toggleValue1)

	local rate = self:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Auto,
		[StatEnum.EventProperties.Rate] = rate
	})
end

function SettingsLimitedRoleMO:setManual()
	self._toggleValue1 = ToggleValue1Manual

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, self._toggleValue1)

	local rate = self:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Manual,
		[StatEnum.EventProperties.Rate] = rate
	})
end

function SettingsLimitedRoleMO:setEveryLogin()
	self._toggleValue2 = ToggleValue2EveryLogin

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, self._toggleValue2)

	local manualAuto = self:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = manualAuto,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Time
	})
end

function SettingsLimitedRoleMO:setDaily()
	self._toggleValue2 = ToggleValue2Daily

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, self._toggleValue2)

	local manualAuto = self:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = manualAuto,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Daily
	})
end

function SettingsLimitedRoleMO:getTodayHasPlay()
	local lastPlayTS = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, 0)
	local serverDateTime = os.date("*t", ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshSecond)

	serverDateTime.hour = 0
	serverDateTime.min = 0
	serverDateTime.sec = 0

	local serverTodayRefreshTs = os.time(serverDateTime) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()

	return serverTodayRefreshTs < lastPlayTS
end

function SettingsLimitedRoleMO:setTodayHasPlay()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, ServerTime.now() - TimeDispatcher.DailyRefreshSecond)
end

return SettingsLimitedRoleMO
