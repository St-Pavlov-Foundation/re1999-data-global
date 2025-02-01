module("modules.logic.settings.model.SettingsLimitedRoleMO", package.seeall)

slot0 = class("SettingsLimitedRoleMO")
slot1 = 0
slot2 = 1
slot3 = 0
slot4 = 1

function slot0.ctor(slot0)
	slot0._toggleValue1 = nil
	slot0._toggleValue2 = nil
end

function slot0.reInit(slot0)
	slot0._toggleValue1 = nil
	slot0._toggleValue2 = nil
end

function slot0._checkReadLocalValue(slot0)
	if not slot0._toggleValue1 then
		slot0._toggleValue1 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, uv0)
	end

	if not slot0._toggleValue2 then
		slot0._toggleValue2 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, uv1)
	end
end

function slot0.isAuto(slot0)
	slot0:_checkReadLocalValue()

	return slot0._toggleValue1 == uv0
end

function slot0.isEveryLogin(slot0)
	slot0:_checkReadLocalValue()

	return slot0._toggleValue2 == uv0
end

function slot0.isDaily(slot0)
	slot0:_checkReadLocalValue()

	return slot0._toggleValue2 == uv0
end

function slot0.setAuto(slot0)
	slot0._toggleValue1 = uv0

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, slot0._toggleValue1)
	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Auto,
		[StatEnum.EventProperties.Rate] = slot0:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time
	})
end

function slot0.setManual(slot0)
	slot0._toggleValue1 = uv0

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, slot0._toggleValue1)
	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Manual,
		[StatEnum.EventProperties.Rate] = slot0:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time
	})
end

function slot0.setEveryLogin(slot0)
	slot0._toggleValue2 = uv0

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, slot0._toggleValue2)
	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = slot0:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Time
	})
end

function slot0.setDaily(slot0)
	slot0._toggleValue2 = uv0

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, slot0._toggleValue2)
	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = slot0:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Daily
	})
end

function slot0.getTodayHasPlay(slot0)
	slot2 = os.date("*t", ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshSecond)
	slot2.hour = 0
	slot2.min = 0
	slot2.sec = 0

	return GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, 0) > os.time(slot2) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function slot0.setTodayHasPlay(slot0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, ServerTime.now() - TimeDispatcher.DailyRefreshSecond)
end

return slot0
