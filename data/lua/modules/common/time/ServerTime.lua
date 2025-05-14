module("modules.common.time.ServerTime", package.seeall)

local var_0_0 = _M
local var_0_1 = 0
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = os.time()
local var_0_5 = 0

function var_0_0.init(arg_1_0)
	var_0_1 = arg_1_0 or var_0_0.getInitServerUtcOffset()
	var_0_2 = os.difftime(os.time(), os.time(os.date("!*t", os.time())))
	var_0_3 = var_0_1 - var_0_2
end

function var_0_0.getInitServerUtcOffset()
	local var_2_0 = GameConfig:GetCurRegionType()

	if RegionEnum and RegionEnum.utcOffset[var_2_0] then
		return RegionEnum.utcOffset[var_2_0]
	else
		return ModuleEnum.ServerUtcOffset
	end
end

function var_0_0.clientToServerOffset()
	return var_0_3
end

function var_0_0.update(arg_4_0)
	var_0_4 = arg_4_0
	var_0_5 = Time.realtimeSinceStartup
end

function var_0_0.now()
	local var_5_0 = Time.realtimeSinceStartup - var_0_5

	return var_0_4 + math.floor(var_5_0)
end

function var_0_0.nowInLocal()
	return var_0_0.now() + var_0_3 + var_0_0.getDstOffset()
end

function var_0_0.timeInLocal(arg_7_0)
	return arg_7_0 + var_0_3 + var_0_0.getDstOffset()
end

function var_0_0.nowDate()
	return (os.date("*t", var_0_0.now()))
end

function var_0_0.nowDateInLocal()
	return (os.date("*t", var_0_0.nowInLocal()))
end

function var_0_0.weekDayInServerLocal()
	local var_10_0 = os.date("*t", var_0_0.nowInLocal() - 18000)

	return TimeUtil.convertWday(var_10_0.wday)
end

function var_0_0.timeDateInLocal(arg_11_0)
	local var_11_0 = var_0_0.timeInLocal(arg_11_0)

	return (os.date("*t", var_11_0))
end

function var_0_0.formatNow(arg_12_0)
	return os.date(arg_12_0, var_0_0.now())
end

function var_0_0.serverUtcOffset()
	return var_0_1
end

function var_0_0.formatNowInLocal(arg_14_0)
	local var_14_0 = var_0_0.nowInLocal()

	return os.date(arg_14_0, var_14_0)
end

function var_0_0.formatTimeInLocal(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.timeInLocal(arg_15_0)

	return os.date(arg_15_1, var_15_0)
end

function var_0_0.getDstOffset()
	return os.date("*t", os.time()).isdst and -3600 or 0
end

function var_0_0.timestampToString(arg_17_0)
	return (os.date("%Y-%m-%d %H:%M:%S", arg_17_0 + var_0_3 + var_0_0.getDstOffset()))
end

function var_0_0.ReplaceUTCStr(arg_18_0)
	if arg_18_0 then
		return string.gsub(arg_18_0, "UTC%+8", var_0_0.GetUTCOffsetStr())
	else
		return ""
	end
end

function var_0_0.getServerTimeToday(arg_19_0)
	local var_19_0 = var_0_0.nowInLocal()

	if arg_19_0 then
		var_19_0 = var_19_0 - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	end

	return tonumber(os.date("%d", var_19_0))
end

function var_0_0.getToadyEndTimeStamp(arg_20_0)
	local var_20_0 = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local var_20_1 = var_0_0.nowInLocal()

	if arg_20_0 then
		var_20_1 = var_20_1 - var_20_0
	end

	local var_20_2 = os.date("*t", var_20_1)
	local var_20_3 = os.time({
		hour = 23,
		min = 59,
		sec = 59,
		year = var_20_2.year,
		month = var_20_2.month,
		day = var_20_2.day
	})

	if arg_20_0 then
		var_20_3 = var_20_3 + var_20_0
	end

	return var_20_3 + 1
end

function var_0_0.getWeekEndTimeStamp(arg_21_0)
	local var_21_0 = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local var_21_1 = var_0_0.nowDateInLocal()
	local var_21_2 = TimeUtil.getTodayWeedDay(var_21_1)
	local var_21_3 = true

	if var_21_2 == 1 and arg_21_0 and var_21_0 > var_21_1.hour * 3600 + var_21_1.min * 60 + var_21_1.sec then
		var_21_3 = false
	end

	local var_21_4

	if not var_21_3 then
		var_21_4 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = var_21_1.year,
			month = var_21_1.month,
			day = var_21_1.day
		}
	else
		local var_21_5 = 7 - var_21_2
		local var_21_6 = var_21_1.day + var_21_5 + 1
		local var_21_7 = var_21_1.month
		local var_21_8 = var_21_1.year

		if var_21_7 == 2 then
			local var_21_9 = var_21_1.year % 400 == 0 or var_21_1.year % 4 == 0 and var_21_8 % 100 ~= 0

			if var_21_6 > 29 and var_21_9 then
				var_21_7 = var_21_7 + 1
				var_21_6 = var_21_6 - 29
			elseif var_21_6 > 28 then
				var_21_7 = var_21_7 + 1
				var_21_6 = var_21_6 - 28
			end
		elseif var_21_7 == 4 or var_21_7 == 6 or var_21_7 == 9 or var_21_7 == 11 then
			if var_21_6 > 30 then
				var_21_7 = var_21_7 + 1
				var_21_6 = var_21_6 - 30
			end
		elseif var_21_6 > 31 then
			var_21_7 = var_21_7 + 1
			var_21_6 = var_21_6 - 31
		end

		if var_21_7 > 12 then
			var_21_8 = var_21_8 + 1
			var_21_7 = var_21_7 - 12
		end

		var_21_4 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = var_21_8,
			month = var_21_7,
			day = var_21_6
		}
	end

	local var_21_10 = os.time(var_21_4)

	if arg_21_0 then
		var_21_10 = var_21_10 + var_21_0
	end

	return var_0_0.clientTs2ServerTs(var_21_10)
end

function var_0_0.getMonthEndTimeStamp(arg_22_0)
	local var_22_0 = TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local var_22_1 = var_0_0.nowDateInLocal()
	local var_22_2 = true

	if var_22_1.day == 1 and arg_22_0 and var_22_0 > var_22_1.hour * 3600 + var_22_1.min * 60 + var_22_1.sec then
		var_22_2 = false
	end

	if var_22_2 then
		if var_22_1.month == 12 then
			var_22_1.year = var_22_1.year + 1
			var_22_1.month = 1
		else
			var_22_1.month = var_22_1.month + 1
		end
	end

	local var_22_3 = {
		hour = 0,
		min = 0,
		sec = 0,
		day = 1,
		year = var_22_1.year,
		month = var_22_1.month
	}
	local var_22_4 = os.time(var_22_3)

	if arg_22_0 then
		var_22_4 = var_22_4 + var_22_0
	end

	return var_0_0.clientTs2ServerTs(var_22_4)
end

function var_0_0.clientTs2ServerTs(arg_23_0)
	return arg_23_0 - var_0_0.clientToServerOffset() - var_0_0.getDstOffset()
end

function var_0_0.GetUTCOffsetStr()
	return string.format("UTC%+d", var_0_1 / 3600)
end

return var_0_0
