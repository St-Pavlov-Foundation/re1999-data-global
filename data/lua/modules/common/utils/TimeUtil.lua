module("modules.common.utils.TimeUtil", package.seeall)

local var_0_0 = {}

function var_0_0.getFormatTime_overseas(arg_1_0)
	if not arg_1_0 or arg_1_0 <= 0 then
		return 0 .. luaLang("time_minute2")
	end

	local var_1_0, var_1_1, var_1_2, var_1_3 = var_0_0.secondsToDDHHMMSS(arg_1_0)

	if var_1_0 > 0 then
		local var_1_4 = luaLang("time_day")

		if LangSettings.instance:isEn() then
			var_1_4 = var_1_4 .. " "
		end

		return var_1_0 .. var_1_4 .. var_1_1 .. luaLang("time_hour2")
	elseif var_1_1 > 0 then
		local var_1_5 = luaLang("time_hour2")

		if LangSettings.instance:isEn() then
			var_1_5 = var_1_5 .. " "
		end

		return var_1_1 .. var_1_5 .. var_1_2 .. luaLang("time_minute2")
	elseif var_1_2 > 0 then
		return var_1_2 .. luaLang("time_minute2")
	end

	return "<1" .. luaLang("time_minute2")
end

var_0_0.maxDateTable = {
	month = 1,
	year = 2038,
	day = 1
}
var_0_0.OneDaySecond = 86400
var_0_0.OneHourSecond = 3600
var_0_0.OneMinuteSecond = 60
var_0_0.OneSecond = 1
var_0_0.DateEnFormat = {
	Day = "d",
	Hour = "h",
	Year = "y",
	Second = "s",
	Minute = "m"
}

function var_0_0.second2TimeString(arg_2_0, arg_2_1)
	arg_2_0 = math.floor(arg_2_0)

	local var_2_0 = math.floor(arg_2_0 / 3600)
	local var_2_1 = math.floor(arg_2_0 % 3600 / 60)
	local var_2_2 = math.floor(arg_2_0 % 60)

	if arg_2_1 then
		return string.format("%02d:%02d:%02d", var_2_0, var_2_1, var_2_2)
	else
		return string.format("%02d:%02d", var_2_1, var_2_2)
	end
end

function var_0_0.secondsToDDHHMMSS(arg_3_0)
	arg_3_0 = math.floor(arg_3_0)

	local var_3_0 = math.floor(arg_3_0 / 86400)
	local var_3_1 = math.floor(arg_3_0 % 86400 / 3600)
	local var_3_2 = math.floor(arg_3_0 % 3600 / 60)
	local var_3_3 = math.floor(arg_3_0 % 60)

	return var_3_0, var_3_1, var_3_2, var_3_3
end

function var_0_0.stringToTimestamp(arg_4_0)
	if string.nilorempty(arg_4_0) then
		return 0
	end

	local var_4_0, var_4_1, var_4_2, var_4_3, var_4_4, var_4_5, var_4_6, var_4_7 = string.find(arg_4_0, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

	if not var_4_2 or not var_4_3 or not var_4_4 or not var_4_5 or not var_4_6 or not var_4_7 then
		logError("请输入正确的时间文本格式!")

		return 0
	end

	local var_4_8 = {
		year = var_4_2,
		month = var_4_3,
		day = var_4_4,
		hour = var_4_5,
		min = var_4_6,
		sec = var_4_7
	}

	return var_0_0.dtTableToTimeStamp(var_4_8) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function var_0_0.timeToTimeStamp(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = {
		year = arg_5_0,
		month = arg_5_1,
		day = arg_5_2,
		hour = arg_5_3,
		min = arg_5_4,
		sec = arg_5_5
	}

	return var_0_0.dtTableToTimeStamp(var_5_0) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function var_0_0.dtTableToTimeStamp(arg_6_0)
	local var_6_0 = os.time(arg_6_0)

	if not var_6_0 then
		var_6_0 = os.time(var_0_0.maxDateTable)

		logError("os.time 32位溢出，输入时间超出2038年")
	end

	return var_6_0
end

function var_0_0.timestampToString(arg_7_0)
	return (os.date("%Y-%m-%d %H:%M:%S", arg_7_0))
end

function var_0_0.langTimestampToString(arg_8_0)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y %H:%M:%S", arg_8_0)
	else
		return os.date("%Y-%m-%d %H:%M:%S", arg_8_0)
	end
end

function var_0_0.timestampToString1(arg_9_0)
	return (os.date("%Y-%m-%d", arg_9_0))
end

function var_0_0.timestampToString2(arg_10_0)
	return (string.format(os.date("%Y%%s%m%%s%d%%s", arg_10_0), luaLang("time_year"), luaLang("time_month"), luaLang("time_day2")))
end

function var_0_0.timestampToString3(arg_11_0)
	return (os.date("%Y.%m.%d", arg_11_0))
end

function var_0_0.langTimestampToString3(arg_12_0)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y", arg_12_0)
	else
		return os.date("%Y.%m.%d", arg_12_0)
	end
end

function var_0_0.timestampToString4(arg_13_0)
	return (os.date("%H:%M", arg_13_0))
end

function var_0_0.timestampToString5(arg_14_0)
	return (os.date("%Y/%m/%d", arg_14_0))
end

function var_0_0.timestampToString6(arg_15_0)
	return (os.date("%Y-%m-%d %H", arg_15_0))
end

function var_0_0.localTime2ServerTimeString(arg_16_0, arg_16_1)
	if arg_16_0 then
		arg_16_1 = arg_16_1 or "%Y/%m/%d"

		return (os.date(arg_16_1, ServerTime.timeInLocal(arg_16_0)))
	end
end

function var_0_0.timestampToTable(arg_17_0)
	local var_17_0 = os.date("%Y#%m#%d#%H#%M#%S", arg_17_0)
	local var_17_1 = string.split(var_17_0, "#")
	local var_17_2 = tonumber(var_17_1[1])
	local var_17_3 = tonumber(var_17_1[2])
	local var_17_4 = tonumber(var_17_1[3])
	local var_17_5 = tonumber(var_17_1[4])
	local var_17_6 = tonumber(var_17_1[5])
	local var_17_7 = tonumber(var_17_1[6])

	return {
		year = var_17_2,
		month = var_17_3,
		day = var_17_4,
		hour = var_17_5,
		min = var_17_6,
		sec = var_17_7
	}
end

function var_0_0.secondToRoughTime(arg_18_0, arg_18_1)
	arg_18_0 = math.floor(arg_18_0)

	local var_18_0 = math.floor(arg_18_0 / 86400)
	local var_18_1 = math.floor(arg_18_0 % 86400 / 3600)
	local var_18_2 = math.floor(arg_18_0 % 3600 / 60)
	local var_18_3
	local var_18_4
	local var_18_5 = false

	if var_18_0 > 0 then
		var_18_3 = var_18_0
		var_18_4 = arg_18_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")
		var_18_5 = true
	elseif var_18_1 > 0 then
		var_18_3 = var_18_1
		var_18_4 = arg_18_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	else
		var_18_3 = var_18_2 > 0 and var_18_2 or "<1"
		var_18_4 = arg_18_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute")
	end

	return var_18_3, var_18_4, var_18_5
end

function var_0_0.secondToRoughTime2(arg_19_0, arg_19_1)
	arg_19_0 = math.floor(arg_19_0)

	local var_19_0 = math.floor(arg_19_0 / 86400)
	local var_19_1 = math.floor(arg_19_0 % 86400 / 3600)
	local var_19_2 = math.ceil(arg_19_0 % 3600 / 60)
	local var_19_3
	local var_19_4

	if var_19_0 > 0 then
		var_19_3 = var_19_0
		var_19_4 = arg_19_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")
	elseif var_19_1 > 0 then
		var_19_3 = var_19_1
		var_19_4 = arg_19_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	elseif var_19_2 >= 60 then
		var_19_3 = 1
		var_19_4 = arg_19_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	else
		var_19_3 = var_19_2
		var_19_4 = arg_19_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute")
	end

	return var_19_3, var_19_4
end

function var_0_0.secondToRoughTime3(arg_20_0, arg_20_1)
	arg_20_0 = math.floor(arg_20_0)

	local var_20_0 = math.floor(arg_20_0 / 86400)
	local var_20_1 = math.floor(arg_20_0 % 86400 / 3600)
	local var_20_2 = math.floor(arg_20_0 % 3600 / 60)
	local var_20_3
	local var_20_4

	if var_20_0 > 0 then
		var_20_3 = arg_20_1 and " " .. var_20_0 .. " " .. var_0_0.DateEnFormat.Day .. " " .. var_20_1 .. " " .. var_0_0.DateEnFormat.Hour or " " .. var_20_0 .. " " .. luaLang("time_day") .. " " .. var_20_1 .. " " .. luaLang("time_hour")
	elseif var_20_1 > 0 then
		var_20_3 = arg_20_1 and " " .. var_20_1 .. " " .. var_0_0.DateEnFormat.Hour .. " " .. var_20_2 .. " " .. var_0_0.DateEnFormat.Minute or " " .. var_20_1 .. " " .. luaLang("time_hour") .. " " .. var_20_2 .. " " .. luaLang("time_minute")
	elseif var_20_2 > 0 then
		var_20_3 = arg_20_1 and " " .. var_20_2 .. " " .. var_0_0.DateEnFormat.Minute or var_20_2 .. " " .. luaLang("time_minute")
	else
		var_20_3 = arg_20_1 and " <1 " .. var_0_0.DateEnFormat.Minute or " <1  " .. luaLang("time_minute")
	end

	return var_20_3 or ""
end

function var_0_0.secondToHMS(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = math.floor(var_21_0 / 60 / 60)
	local var_21_2 = var_21_0 - var_21_1 * 60 * 60
	local var_21_3 = math.floor(var_21_2 / 60)
	local var_21_4 = var_21_2 - var_21_3 * 60

	return var_21_1, var_21_3, var_21_4
end

function var_0_0.convertWday(arg_22_0)
	arg_22_0 = arg_22_0 - 1

	if arg_22_0 <= 0 then
		arg_22_0 = 7
	end

	return arg_22_0
end

function var_0_0.weekDayToLangStr(arg_23_0)
	arg_23_0 = tonumber(arg_23_0)

	return luaLang("dungeon_day_" .. arg_23_0)
end

function var_0_0.isSameDay(arg_24_0, arg_24_1)
	local var_24_0 = os.date("!*t", arg_24_0 + ServerTime.serverUtcOffset())
	local var_24_1 = os.date("!*t", arg_24_1 + ServerTime.serverUtcOffset())

	if var_24_0.year ~= var_24_1.year then
		return false
	end

	if var_24_0.month ~= var_24_1.month then
		return false
	end

	if var_24_0.day ~= var_24_1.day then
		return false
	end

	return true
end

function var_0_0.getDiffDay(arg_25_0, arg_25_1)
	local var_25_0 = os.date("%Y#%m#%d#%H#%M#%S", arg_25_0)
	local var_25_1 = string.split(var_25_0, "#")
	local var_25_2 = tonumber(var_25_1[1])
	local var_25_3 = tonumber(var_25_1[2])
	local var_25_4 = tonumber(var_25_1[3])
	local var_25_5 = os.date("%Y#%m#%d#%H#%M#%S", arg_25_1)
	local var_25_6 = string.split(var_25_5, "#")
	local var_25_7 = tonumber(var_25_6[1])
	local var_25_8 = tonumber(var_25_6[2])
	local var_25_9 = tonumber(var_25_6[3])
	local var_25_10 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_25_2,
		month = var_25_3,
		day = var_25_4
	})
	local var_25_11 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_25_7,
		month = var_25_8,
		day = var_25_9
	})

	if not var_25_10 or not var_25_11 then
		logError("os.time 32位溢出，输入时间超出2038年")

		return 0
	end

	return math.abs(var_25_10 - var_25_11) / 60 / 60 / 24
end

function var_0_0.setDayFirstLoginRed(arg_26_0)
	local var_26_0 = var_0_0.timestampToString1(ServerTime.now() - 18000)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. arg_26_0, var_26_0)
end

function var_0_0.getDayFirstLoginRed(arg_27_0)
	local var_27_0 = var_0_0.timestampToString1(ServerTime.now() - 18000)

	return PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. arg_27_0) ~= var_27_0
end

function var_0_0.getTodayWeedDay(arg_28_0)
	if arg_28_0.wday == 1 then
		return 7
	end

	return arg_28_0.wday - 1
end

function var_0_0.getFormatTime2(arg_29_0, arg_29_1)
	arg_29_0 = math.floor(arg_29_0)

	local var_29_0 = math.floor(arg_29_0 / 86400)
	local var_29_1 = math.floor(arg_29_0 % 86400 / 3600)
	local var_29_2 = math.floor(arg_29_0 % 3600 / 60)
	local var_29_3 = arg_29_0 - var_29_0 * 86400 - var_29_1 * 3600 - var_29_2 * 60

	if var_29_0 > 0 then
		local var_29_4 = arg_29_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")
		local var_29_5 = arg_29_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour2")

		return string.format("%s%s%s%s", var_29_0, var_29_4, var_29_1, var_29_5)
	end

	if var_29_1 > 0 then
		local var_29_6 = arg_29_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour2")
		local var_29_7 = arg_29_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute2")

		return string.format("%s%s%s%s", var_29_1, var_29_6, var_29_2, var_29_7)
	end

	local var_29_8 = arg_29_1 and var_0_0.DateEnFormat.Second or luaLang("time_second")

	if var_29_2 > 0 then
		local var_29_9 = arg_29_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute2")

		return string.format("%s%s%s%s", var_29_2, var_29_9, var_29_3, var_29_8)
	else
		return string.format("%s%s", var_29_3, var_29_8)
	end
end

function var_0_0.getFormatTime1(arg_30_0, arg_30_1)
	arg_30_0 = math.floor(arg_30_0)

	local var_30_0 = math.floor(arg_30_0 / 86400)
	local var_30_1 = math.floor(arg_30_0 % 86400 / 3600)
	local var_30_2 = math.floor(arg_30_0 % 3600 / 60)
	local var_30_3 = arg_30_0 - var_30_0 * 86400 - var_30_1 * 3600 - var_30_2 * 60

	if var_30_0 > 0 then
		local var_30_4 = arg_30_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")

		return string.format("%s%s", var_30_0, var_30_4)
	end

	if var_30_1 > 0 then
		local var_30_5 = arg_30_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour2")

		return string.format("%s%s", var_30_1, var_30_5)
	end

	local var_30_6 = arg_30_1 and var_0_0.DateEnFormat.Second or luaLang("time_second")

	if var_30_2 > 0 then
		local var_30_7 = arg_30_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute2")

		return string.format("%s%s", var_30_2, var_30_7)
	else
		return string.format("%s%s", var_30_3, var_30_6)
	end
end

function var_0_0.SecondToActivityTimeFormat(arg_31_0, arg_31_1)
	arg_31_0 = math.floor(arg_31_0)

	local var_31_0
	local var_31_1 = 31536000
	local var_31_2 = math.floor(arg_31_0 / var_31_1)

	if var_31_2 > 0 then
		local var_31_3 = math.floor(arg_31_0 % var_31_1 / var_0_0.OneDaySecond)

		if LangSettings.instance:isEn() then
			var_31_0 = arg_31_1 and var_31_2 .. var_0_0.DateEnFormat.Year .. " " .. var_31_3 .. var_0_0.DateEnFormat.Day or var_31_2 .. luaLang("time_year") .. " " .. var_31_3 .. luaLang("time_day")
		else
			var_31_0 = arg_31_1 and var_31_2 .. var_0_0.DateEnFormat.Year .. var_31_3 .. var_0_0.DateEnFormat.Day or var_31_2 .. luaLang("time_year") .. var_31_3 .. luaLang("time_day")
		end

		return var_31_0
	end

	local var_31_4 = math.floor(arg_31_0 / var_0_0.OneDaySecond)

	if var_31_4 > 0 then
		local var_31_5 = math.floor(arg_31_0 % var_0_0.OneDaySecond / var_0_0.OneHourSecond)

		if LangSettings.instance:isEn() then
			var_31_0 = arg_31_1 and var_31_4 .. var_0_0.DateEnFormat.Day .. " " .. var_31_5 .. var_0_0.DateEnFormat.Hour or var_31_4 .. luaLang("time_day") .. " " .. var_31_5 .. luaLang("time_hour")
		else
			var_31_0 = arg_31_1 and var_31_4 .. var_0_0.DateEnFormat.Day .. var_31_5 .. var_0_0.DateEnFormat.Hour or var_31_4 .. luaLang("time_day") .. var_31_5 .. luaLang("time_hour")
		end

		return var_31_0
	end

	local var_31_6 = math.floor(arg_31_0 / var_0_0.OneHourSecond)

	if var_31_6 > 0 then
		local var_31_7 = math.floor(arg_31_0 % var_0_0.OneHourSecond / var_0_0.OneMinuteSecond)

		if LangSettings.instance:isEn() then
			var_31_0 = arg_31_1 and var_31_6 .. var_0_0.DateEnFormat.Hour .. " " .. var_31_7 .. var_0_0.DateEnFormat.Minute or var_31_6 .. luaLang("time_hour") .. " " .. var_31_7 .. luaLang("time_minute2")
		else
			var_31_0 = arg_31_1 and var_31_6 .. var_0_0.DateEnFormat.Hour .. var_31_7 .. var_0_0.DateEnFormat.Minute or var_31_6 .. luaLang("time_hour") .. var_31_7 .. luaLang("time_minute2")
		end
	else
		local var_31_8 = 0
		local var_31_9 = math.floor(arg_31_0 / var_0_0.OneMinuteSecond)

		if var_31_9 < 1 then
			var_31_9 = 1
		end

		if LangSettings.instance:isEn() then
			var_31_0 = arg_31_1 and var_31_8 .. var_0_0.DateEnFormat.Hour .. " " .. var_31_9 .. var_0_0.DateEnFormat.Minute or var_31_8 .. luaLang("time_hour") .. " " .. var_31_9 .. luaLang("time_minute2")
		else
			var_31_0 = arg_31_1 and var_31_8 .. var_0_0.DateEnFormat.Hour .. var_31_9 .. var_0_0.DateEnFormat.Minute or var_31_8 .. luaLang("time_hour") .. var_31_9 .. luaLang("time_minute2")
		end
	end

	return var_31_0
end

var_0_0.maxDateTimeStamp = var_0_0.dtTableToTimeStamp({
	hour = 0,
	month = 1,
	year = 2038,
	min = 0,
	sec = 0,
	day = 1
})

function var_0_0.getServerDateToString()
	local var_32_0 = ServerTime.nowDateInLocal()

	return string.format("%04d-%02d-%02d %02d:%02d:%02d", var_32_0.year, var_32_0.month, var_32_0.day, var_32_0.hour, var_32_0.min, var_32_0.sec)
end

function var_0_0.getServerDateUTCToString()
	return var_0_0.getServerDateToString() .. " (" .. ServerTime.GetUTCOffsetStr() .. ")"
end

function var_0_0.getTimeStamp(arg_34_0, arg_34_1)
	return var_0_0.dtTableToTimeStamp(arg_34_0) + 3600 * (var_0_0.getCurrentZoneOffset() - arg_34_1) - ServerTime.getDstOffset()
end

function var_0_0.getCurrentZoneOffset()
	return os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600
end

function var_0_0.isDstTime(arg_36_0)
	return os.date("*t", arg_36_0).isdst
end

local var_0_1 = 31536000

function var_0_0.getFormatTime(arg_37_0)
	if not arg_37_0 or arg_37_0 <= 0 then
		return "<1" .. luaLang("time_minute2")
	end

	local var_37_0 = math.floor(arg_37_0 / var_0_1)

	if var_37_0 > 0 then
		local var_37_1 = luaLang("time_year")
		local var_37_2 = math.floor(arg_37_0 % var_0_1 / var_0_0.OneDaySecond)

		if LangSettings.instance:isEn() then
			var_37_1 = var_37_1 .. " "
		end

		return var_37_0 .. var_37_1 .. var_37_2 .. luaLang("time_day")
	end

	local var_37_3, var_37_4, var_37_5, var_37_6 = var_0_0.secondsToDDHHMMSS(arg_37_0)

	if var_37_3 > 0 then
		local var_37_7 = luaLang("time_day")

		if LangSettings.instance:isEn() then
			var_37_7 = var_37_7 .. " "
		end

		return var_37_3 .. var_37_7 .. var_37_4 .. luaLang("time_hour2")
	elseif var_37_4 > 0 then
		local var_37_8 = luaLang("time_hour2")

		if LangSettings.instance:isEn() then
			var_37_8 = var_37_8 .. " "
		end

		return var_37_4 .. var_37_8 .. var_37_5 .. luaLang("time_minute2")
	elseif var_37_5 > 0 then
		return var_37_5 .. luaLang("time_minute2")
	end

	return "<1" .. luaLang("time_minute2")
end

return var_0_0
