module("modules.common.utils.TimeUtil", package.seeall)

local var_0_0 = {
	maxDateTable = {
		month = 1,
		year = 2038,
		day = 1
	}
}

var_0_0.OneWeekSecond = 604800
var_0_0.OneDaySecond = 86400
var_0_0.OneHourSecond = 3600
var_0_0.OneMinuteSecond = 60
var_0_0.OneSecond = 1
var_0_0.OneSecondMilliSecond = 1000
var_0_0.DateEnFormat = {
	Day = "d",
	Hour = "h",
	Year = "y",
	Second = "s",
	Minute = "m"
}

local function var_0_1(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if LangSettings.instance:isEn() then
		return string.format("%s%s %s%s", arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	else
		return string.format("%s%s%s%s", arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	end
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if LangSettings.instance:isZh() == false then
		arg_2_0 = false
	end

	local var_2_0 = arg_2_0 and var_0_0.DateEnFormat.Year or luaLang(arg_2_1)
	local var_2_1 = arg_2_0 and var_0_0.DateEnFormat.Day or luaLang(arg_2_2)
	local var_2_2 = arg_2_0 and var_0_0.DateEnFormat.Hour or luaLang(arg_2_3)
	local var_2_3 = arg_2_0 and var_0_0.DateEnFormat.Minute or luaLang(arg_2_4)
	local var_2_4 = arg_2_0 and var_0_0.DateEnFormat.Second or luaLang(arg_2_5)

	return var_2_0, var_2_1, var_2_2, var_2_3, var_2_4
end

local function var_0_3(arg_3_0)
	return var_0_2(arg_3_0, "time_year", "time_day", "time_hour", "time_minute", "time_second")
end

local function var_0_4(arg_4_0)
	return var_0_2(arg_4_0, "time_year", "time_day", "time_hour2", "time_minute2", "time_second")
end

local function var_0_5(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0, var_5_1, var_5_2, var_5_3, var_5_4 = var_0_2(arg_5_0, "time_year", arg_5_1, arg_5_2, arg_5_3, arg_5_4)

	return var_5_1, var_5_2, var_5_3, var_5_4
end

local function var_0_6(arg_6_0)
	return var_0_5(arg_6_0, "time_day", "time_hour", "time_minute", "time_second")
end

local function var_0_7(arg_7_0)
	return var_0_5(arg_7_0, "time_day", "time_hour2", "time_minute2", "time_second")
end

function var_0_0.secondsToDDHHMMSS(arg_8_0)
	arg_8_0 = math.floor(arg_8_0)

	local var_8_0 = math.floor(arg_8_0 / 86400)
	local var_8_1 = math.floor(arg_8_0 % 86400 / 3600)
	local var_8_2 = math.floor(arg_8_0 % 3600 / 60)
	local var_8_3 = math.floor(arg_8_0 % 60)

	return var_8_0, var_8_1, var_8_2, var_8_3
end

function var_0_0.secondToHMS(arg_9_0)
	local var_9_0, var_9_1, var_9_2, var_9_3 = var_0_0.secondsToDDHHMMSS(arg_9_0)

	if var_9_0 > 0 then
		var_9_1 = var_9_1 + var_9_0 * 24
	end

	return var_9_1, var_9_2, var_9_3
end

function var_0_0.second2TimeString(arg_10_0, arg_10_1)
	local var_10_0, var_10_1, var_10_2 = var_0_0.secondToHMS(arg_10_0)

	if arg_10_1 then
		return string.format("%02d:%02d:%02d", var_10_0, var_10_1, var_10_2)
	else
		return string.format("%02d:%02d", var_10_1, var_10_2)
	end
end

function var_0_0.stringToTimestamp(arg_11_0)
	if string.nilorempty(arg_11_0) then
		return 0
	end

	local var_11_0, var_11_1, var_11_2, var_11_3, var_11_4, var_11_5, var_11_6, var_11_7 = string.find(arg_11_0, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")

	if not var_11_2 or not var_11_3 or not var_11_4 or not var_11_5 or not var_11_6 or not var_11_7 then
		logError("请输入正确的时间文本格式!")

		return 0
	end

	local var_11_8 = {
		year = var_11_2,
		month = var_11_3,
		day = var_11_4,
		hour = var_11_5,
		min = var_11_6,
		sec = var_11_7
	}

	return var_0_0.dtTableToTimeStamp(var_11_8) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function var_0_0.timeToTimeStamp(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = {
		year = arg_12_0,
		month = arg_12_1,
		day = arg_12_2,
		hour = arg_12_3,
		min = arg_12_4,
		sec = arg_12_5
	}

	return var_0_0.dtTableToTimeStamp(var_12_0) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
end

function var_0_0.dtTableToTimeStamp(arg_13_0)
	local var_13_0 = os.time(arg_13_0)

	if not var_13_0 then
		var_13_0 = os.time(var_0_0.maxDateTable)

		logError("os.time 32位溢出，输入时间超出2038年")
	end

	return var_13_0
end

function var_0_0.timestampToString(arg_14_0)
	return (os.date("%Y-%m-%d %H:%M:%S", arg_14_0))
end

function var_0_0.langTimestampToString(arg_15_0)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y %H:%M:%S", arg_15_0)
	else
		return os.date("%Y-%m-%d %H:%M:%S", arg_15_0)
	end
end

function var_0_0.timestampToString1(arg_16_0)
	return (os.date("%Y-%m-%d", arg_16_0))
end

function var_0_0.timestampToString2(arg_17_0)
	return (string.format(os.date("%Y%%s%m%%s%d%%s", arg_17_0), luaLang("time_year"), luaLang("time_month"), luaLang("time_day2")))
end

function var_0_0.timestampToString3(arg_18_0)
	return (os.date("%Y.%m.%d", arg_18_0))
end

function var_0_0.langTimestampToString3(arg_19_0)
	if LangSettings.instance:getCurLangShortcut() == "en" then
		return os.date("%m/%d/%Y", arg_19_0)
	else
		return os.date("%Y.%m.%d", arg_19_0)
	end
end

function var_0_0.timestampToString4(arg_20_0)
	return (os.date("%H:%M", arg_20_0))
end

function var_0_0.timestampToString5(arg_21_0)
	return (os.date("%Y/%m/%d", arg_21_0))
end

function var_0_0.timestampToString6(arg_22_0)
	return (os.date("%Y-%m-%d %H", arg_22_0))
end

function var_0_0.localTime2ServerTimeString(arg_23_0, arg_23_1)
	if arg_23_0 then
		arg_23_1 = arg_23_1 or "%Y/%m/%d"

		return (os.date(arg_23_1, ServerTime.timeInLocal(arg_23_0)))
	end
end

function var_0_0.timestampToTable(arg_24_0)
	local var_24_0 = os.date("%Y#%m#%d#%H#%M#%S", arg_24_0)
	local var_24_1 = string.split(var_24_0, "#")
	local var_24_2 = tonumber(var_24_1[1])
	local var_24_3 = tonumber(var_24_1[2])
	local var_24_4 = tonumber(var_24_1[3])
	local var_24_5 = tonumber(var_24_1[4])
	local var_24_6 = tonumber(var_24_1[5])
	local var_24_7 = tonumber(var_24_1[6])

	return {
		year = var_24_2,
		month = var_24_3,
		day = var_24_4,
		hour = var_24_5,
		min = var_24_6,
		sec = var_24_7
	}
end

function var_0_0.secondToRoughTime(arg_25_0, arg_25_1)
	if LangSettings.instance:isZh() == false then
		arg_25_1 = false
	end

	local var_25_0, var_25_1, var_25_2, var_25_3 = var_0_0.secondsToDDHHMMSS(arg_25_0)
	local var_25_4
	local var_25_5
	local var_25_6 = var_25_0 > 0

	if var_25_0 > 0 then
		var_25_4 = var_25_0
		var_25_5 = arg_25_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")
	elseif var_25_1 > 0 then
		var_25_4 = var_25_1
		var_25_5 = arg_25_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	else
		var_25_4 = var_25_2 > 0 and var_25_2 or "<1"
		var_25_5 = arg_25_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute")
	end

	return var_25_4, var_25_5, var_25_6
end

function var_0_0.secondToRoughTime2(arg_26_0, arg_26_1)
	if LangSettings.instance:isZh() == false then
		arg_26_1 = false
	end

	local var_26_0, var_26_1, var_26_2, var_26_3 = var_0_0.secondsToDDHHMMSS(arg_26_0)
	local var_26_4
	local var_26_5

	if var_26_0 > 0 then
		var_26_4 = var_26_0
		var_26_5 = arg_26_1 and var_0_0.DateEnFormat.Day or luaLang("time_day")
	elseif var_26_1 > 0 then
		var_26_4 = var_26_1
		var_26_5 = arg_26_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	elseif var_26_2 >= 60 then
		var_26_4 = 1
		var_26_5 = arg_26_1 and var_0_0.DateEnFormat.Hour or luaLang("time_hour")
	else
		var_26_4 = var_26_2
		var_26_5 = arg_26_1 and var_0_0.DateEnFormat.Minute or luaLang("time_minute")
	end

	return var_26_4, var_26_5
end

function var_0_0.secondToRoughTime3(arg_27_0, arg_27_1)
	if LangSettings.instance:isZh() == false then
		arg_27_1 = false
	end

	local var_27_0, var_27_1, var_27_2, var_27_3 = var_0_0.secondsToDDHHMMSS(arg_27_0)
	local var_27_4, var_27_5, var_27_6 = var_0_6(arg_27_1)

	if var_27_0 > 0 then
		return var_0_1(var_27_0, var_27_4, var_27_1, var_27_5)
	elseif var_27_1 > 0 then
		return var_0_1(var_27_1, var_27_5, var_27_2, var_27_6)
	elseif var_27_2 > 0 then
		return arg_27_1 and " " .. var_27_2 .. " " .. var_0_0.DateEnFormat.Minute or var_27_2 .. " " .. luaLang("time_minute")
	else
		return luaLang("summonmain_deadline_time_min")
	end
end

function var_0_0.convertWday(arg_28_0)
	arg_28_0 = arg_28_0 - 1

	if arg_28_0 <= 0 then
		arg_28_0 = 7
	end

	return arg_28_0
end

function var_0_0.weekDayToLangStr(arg_29_0)
	local var_29_0 = string.format("weekday%s", arg_29_0)

	return luaLang(var_29_0)
end

function var_0_0.isSameDay(arg_30_0, arg_30_1)
	local var_30_0 = os.date("!*t", arg_30_0 + ServerTime.serverUtcOffset())
	local var_30_1 = os.date("!*t", arg_30_1 + ServerTime.serverUtcOffset())

	if var_30_0.year ~= var_30_1.year then
		return false
	end

	if var_30_0.month ~= var_30_1.month then
		return false
	end

	if var_30_0.day ~= var_30_1.day then
		return false
	end

	return true
end

function var_0_0.getDiffDay(arg_31_0, arg_31_1)
	local var_31_0 = os.date("%Y#%m#%d#%H#%M#%S", arg_31_0)
	local var_31_1 = string.split(var_31_0, "#")
	local var_31_2 = tonumber(var_31_1[1])
	local var_31_3 = tonumber(var_31_1[2])
	local var_31_4 = tonumber(var_31_1[3])
	local var_31_5 = os.date("%Y#%m#%d#%H#%M#%S", arg_31_1)
	local var_31_6 = string.split(var_31_5, "#")
	local var_31_7 = tonumber(var_31_6[1])
	local var_31_8 = tonumber(var_31_6[2])
	local var_31_9 = tonumber(var_31_6[3])
	local var_31_10 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_31_2,
		month = var_31_3,
		day = var_31_4
	})
	local var_31_11 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_31_7,
		month = var_31_8,
		day = var_31_9
	})

	if not var_31_10 or not var_31_11 then
		logError("os.time 32位溢出，输入时间超出2038年")

		return 0
	end

	return math.abs(var_31_10 - var_31_11) / 60 / 60 / 24
end

function var_0_0.setDayFirstLoginRed(arg_32_0)
	local var_32_0 = var_0_0.timestampToString1(ServerTime.now() - 18000)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. arg_32_0, var_32_0)
end

function var_0_0.getDayFirstLoginRed(arg_33_0)
	local var_33_0 = var_0_0.timestampToString1(ServerTime.now() - 18000)

	return PlayerPrefsHelper.getString(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginTodayRed .. "_" .. arg_33_0) ~= var_33_0
end

function var_0_0.setWeekFirstLoginRed(arg_34_0)
	local var_34_0 = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. arg_34_0, var_34_0)
end

function var_0_0.getWeekFirstLoginRed(arg_35_0)
	local var_35_0 = math.floor(ServerTime.getWeekEndTimeStamp(true) / 3600)

	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayinfo().userId .. "_" .. PlayerPrefsKey.FirstLoginWeekRed .. "_" .. arg_35_0, 0) ~= var_35_0
end

function var_0_0.getTodayWeedDay(arg_36_0)
	if arg_36_0.wday == 1 then
		return 7
	end

	return arg_36_0.wday - 1
end

function var_0_0.getFormatTime2(arg_37_0, arg_37_1)
	if LangSettings.instance:isZh() == false then
		arg_37_1 = false
	end

	local var_37_0, var_37_1, var_37_2, var_37_3 = var_0_0.secondsToDDHHMMSS(arg_37_0)
	local var_37_4, var_37_5, var_37_6, var_37_7 = var_0_7(arg_37_1)

	if var_37_0 > 0 then
		return var_0_1(var_37_0, var_37_4, var_37_1, var_37_5)
	elseif var_37_1 > 0 then
		return var_0_1(var_37_1, var_37_5, var_37_2, var_37_6)
	elseif var_37_2 > 0 then
		return var_0_1(var_37_2, var_37_6, var_37_3, var_37_7)
	else
		return string.format("%s%s", var_37_3, var_37_7)
	end
end

function var_0_0.getFormatTime1(arg_38_0, arg_38_1)
	if LangSettings.instance:isZh() == false then
		arg_38_1 = false
	end

	local var_38_0, var_38_1, var_38_2, var_38_3 = var_0_0.secondsToDDHHMMSS(arg_38_0)
	local var_38_4, var_38_5, var_38_6, var_38_7 = var_0_7(arg_38_1)

	if var_38_0 > 0 then
		return string.format("%s%s", var_38_0, var_38_4)
	elseif var_38_1 > 0 then
		return string.format("%s%s", var_38_1, var_38_5)
	elseif var_38_2 > 0 then
		return string.format("%s%s", var_38_2, var_38_6)
	else
		return string.format("%s%s", var_38_3, var_38_7)
	end
end

local var_0_8 = 31536000

function var_0_0.SecondToActivityTimeFormat(arg_39_0, arg_39_1)
	if LangSettings.instance:isZh() == false then
		arg_39_1 = false
	end

	local var_39_0 = math.floor(arg_39_0 / var_0_8)
	local var_39_1, var_39_2, var_39_3, var_39_4 = var_0_0.secondsToDDHHMMSS(arg_39_0 % var_0_8)
	local var_39_5, var_39_6, var_39_7, var_39_8, var_39_9 = var_0_4(arg_39_1)

	if var_39_0 > 0 then
		return var_0_1(var_39_0, var_39_5, var_39_1, var_39_6)
	elseif var_39_1 > 0 then
		return var_0_1(var_39_1, var_39_6, var_39_2, var_39_7)
	elseif var_39_2 > 0 then
		return var_0_1(var_39_2, var_39_7, var_39_3, var_39_8)
	else
		return var_0_1(0, var_39_7, math.max(1, var_39_3), var_39_8)
	end
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
	local var_40_0 = ServerTime.nowDateInLocal()

	return string.format("%04d-%02d-%02d %02d:%02d:%02d", var_40_0.year, var_40_0.month, var_40_0.day, var_40_0.hour, var_40_0.min, var_40_0.sec)
end

function var_0_0.getServerDateUTCToString()
	return var_0_0.getServerDateToString() .. " (" .. ServerTime.GetUTCOffsetStr() .. ")"
end

function var_0_0.getTimeStamp(arg_42_0, arg_42_1)
	return var_0_0.dtTableToTimeStamp(arg_42_0) + 3600 * (var_0_0.getCurrentZoneOffset() - arg_42_1) - ServerTime.getDstOffset()
end

function var_0_0.getCurrentZoneOffset()
	return os.difftime(os.time(), os.time(os.date("!*t", os.time()))) / 3600
end

function var_0_0.isDstTime(arg_44_0)
	return os.date("*t", arg_44_0).isdst
end

function var_0_0.getFormatTime(arg_45_0)
	if not arg_45_0 or arg_45_0 <= 0 then
		return luaLang("summonmain_deadline_time_min")
	end

	local var_45_0 = math.floor(arg_45_0 / var_0_8)
	local var_45_1, var_45_2, var_45_3, var_45_4 = var_0_0.secondsToDDHHMMSS(arg_45_0 % var_0_8)
	local var_45_5, var_45_6, var_45_7, var_45_8, var_45_9 = var_0_4()

	if var_45_0 > 0 then
		return var_0_1(var_45_0, var_45_5, var_45_1, var_45_6)
	elseif var_45_1 > 0 then
		return var_0_1(var_45_1, var_45_6, var_45_2, var_45_7)
	elseif var_45_2 > 0 then
		return var_0_1(var_45_2, var_45_7, var_45_3, var_45_8)
	elseif var_45_3 > 0 then
		return string.format("%s%s", var_45_3, var_45_8)
	else
		return luaLang("summonmain_deadline_time_min")
	end
end

return var_0_0
