module("modules.logic.settings.model.SettingsLimitedRoleMO", package.seeall)

local var_0_0 = class("SettingsLimitedRoleMO")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 0
local var_0_4 = 1

function var_0_0.ctor(arg_1_0)
	arg_1_0._toggleValue1 = nil
	arg_1_0._toggleValue2 = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._toggleValue1 = nil
	arg_2_0._toggleValue2 = nil
end

function var_0_0._checkReadLocalValue(arg_3_0)
	if not arg_3_0._toggleValue1 then
		arg_3_0._toggleValue1 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, var_0_1)
	end

	if not arg_3_0._toggleValue2 then
		arg_3_0._toggleValue2 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, var_0_3)
	end
end

function var_0_0.isAuto(arg_4_0)
	arg_4_0:_checkReadLocalValue()

	return arg_4_0._toggleValue1 == var_0_1
end

function var_0_0.isEveryLogin(arg_5_0)
	arg_5_0:_checkReadLocalValue()

	return arg_5_0._toggleValue2 == var_0_3
end

function var_0_0.isDaily(arg_6_0)
	arg_6_0:_checkReadLocalValue()

	return arg_6_0._toggleValue2 == var_0_4
end

function var_0_0.setAuto(arg_7_0)
	arg_7_0._toggleValue1 = var_0_1

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, arg_7_0._toggleValue1)

	local var_7_0 = arg_7_0:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Auto,
		[StatEnum.EventProperties.Rate] = var_7_0
	})
end

function var_0_0.setManual(arg_8_0)
	arg_8_0._toggleValue1 = var_0_2

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole1, arg_8_0._toggleValue1)

	local var_8_0 = arg_8_0:isDaily() and StatEnum.Rate.Daily or StatEnum.Rate.Time

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = StatEnum.ManualAuto.Manual,
		[StatEnum.EventProperties.Rate] = var_8_0
	})
end

function var_0_0.setEveryLogin(arg_9_0)
	arg_9_0._toggleValue2 = var_0_3

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, arg_9_0._toggleValue2)

	local var_9_0 = arg_9_0:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = var_9_0,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Time
	})
end

function var_0_0.setDaily(arg_10_0)
	arg_10_0._toggleValue2 = var_0_4

	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole2, arg_10_0._toggleValue2)

	local var_10_0 = arg_10_0:isAuto() and StatEnum.ManualAuto.Auto or StatEnum.ManualAuto.Manual

	StatController.instance:track(StatEnum.EventName.SetVisitingAnimation, {
		[StatEnum.EventProperties.ManualAuto] = var_10_0,
		[StatEnum.EventProperties.Rate] = StatEnum.Rate.Daily
	})
end

function var_0_0.getTodayHasPlay(arg_11_0)
	local var_11_0 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, 0)
	local var_11_1 = os.date("*t", ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshSecond)

	var_11_1.hour = 0
	var_11_1.min = 0
	var_11_1.sec = 0

	return var_11_0 > os.time(var_11_1) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function var_0_0.setTodayHasPlay(arg_12_0)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.SettingsLimitedRole3, ServerTime.now() - TimeDispatcher.DailyRefreshSecond)
end

return var_0_0
