module("modules.common.time.TimeDispatcher", package.seeall)

local var_0_0 = class("TimeDispatcher")

var_0_0.OnHour = "OnHour"
var_0_0.OnDay = "OnDay"
var_0_0.OnWeek = "OnWeek"
var_0_0.OnDailyRefresh = "OnDailyRefresh"
var_0_0.CheckInterval = 5
var_0_0.DailyRefreshTime = 5
var_0_0.DailyRefreshSecond = var_0_0.DailyRefreshTime * 3600

function var_0_0.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)

	arg_1_0._lastCheckYear = -1
	arg_1_0._lastCheckYDay = -1
	arg_1_0._lastCheckHour = -1
	arg_1_0._lastCheckWDay = -1
	arg_1_0._lastCheckStamp = -1
	arg_1_0._year = 0
	arg_1_0._yday = 0
	arg_1_0._wday = 0
	arg_1_0._hour = 0
	arg_1_0._stamp = 0
end

function var_0_0.startTick(arg_2_0)
	arg_2_0:_check(true)
	TaskDispatcher.runRepeat(arg_2_0._check, arg_2_0, var_0_0.CheckInterval)
end

function var_0_0.stopTick(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._check, arg_3_0)

	arg_3_0._lastCheckYear = -1
	arg_3_0._lastCheckYDay = -1
	arg_3_0._lastCheckHour = -1
	arg_3_0._lastCheckWDay = -1
	arg_3_0._lastCheckStamp = -1
end

function var_0_0._check(arg_4_0, arg_4_1)
	arg_4_0._stamp = ServerTime.nowInLocal()

	local var_4_0 = os.date("*t", arg_4_0._stamp)

	arg_4_0._year = var_4_0.year
	arg_4_0._wday = var_4_0.wday

	if arg_4_0._wday == 1 then
		arg_4_0._wday = 8
	end

	arg_4_0._yday = var_4_0.yday
	arg_4_0._hour = var_4_0.hour

	if arg_4_0:_checkHour() and not arg_4_1 then
		arg_4_0:dispatchEvent(var_0_0.OnHour)

		if arg_4_0:_checkRefreshTime() then
			arg_4_0:dispatchEvent(var_0_0.OnDailyRefresh)
		end

		if arg_4_0:_checkDay() then
			arg_4_0:dispatchEvent(var_0_0.OnDay)

			if arg_4_0:_checkWeek() then
				arg_4_0:dispatchEvent(var_0_0.OnWeek)
			end
		end
	end

	arg_4_0._lastCheckYear = arg_4_0._year
	arg_4_0._lastCheckYDay = arg_4_0._yday
	arg_4_0._lastCheckHour = arg_4_0._hour
	arg_4_0._lastCheckWDay = arg_4_0._wday
	arg_4_0._lastCheckStamp = arg_4_0._stamp
end

function var_0_0._checkHour(arg_5_0)
	if arg_5_0._lastCheckYear < 0 then
		return false
	elseif arg_5_0._lastCheckYear == arg_5_0._year and arg_5_0._lastCheckYDay == arg_5_0._yday and arg_5_0._lastCheckHour == arg_5_0._hour then
		return false
	end

	return true
end

function var_0_0._checkRefreshTime(arg_6_0)
	if arg_6_0._hour == var_0_0.DailyRefreshTime then
		return true
	end

	return false
end

function var_0_0._checkDay(arg_7_0)
	if arg_7_0._lastCheckYear < 0 then
		return false
	elseif arg_7_0._lastCheckYear == arg_7_0._year and arg_7_0._lastCheckYDay == arg_7_0._yday then
		return false
	end

	return true
end

function var_0_0._checkWeek(arg_8_0)
	if arg_8_0._lastCheckStamp < 0 then
		return false
	elseif arg_8_0._stamp - arg_8_0._lastCheckStamp < 604800 and arg_8_0._wday >= arg_8_0._lastCheckWDay then
		return false
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
