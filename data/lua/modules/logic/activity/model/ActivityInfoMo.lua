module("modules.logic.activity.model.ActivityInfoMo", package.seeall)

local var_0_0 = pureTable("ActivityInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.actType = 0
	arg_1_0.centerId = 0
	arg_1_0.startTime = 0
	arg_1_0.endTime = 0
	arg_1_0.online = false
	arg_1_0.isNewStage = false
	arg_1_0.permanentUnlock = false
	arg_1_0.isReceiveAllBonus = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.actType = ActivityConfig.instance:getActivityCo(arg_2_1.id).typeId
	arg_2_0.centerId = ActivityConfig.instance:getActivityCo(arg_2_1.id).showCenter
	arg_2_0.startTime = tonumber(arg_2_1.startTime)
	arg_2_0.endTime = tonumber(arg_2_1.endTime)
	arg_2_0.online = arg_2_1.online
	arg_2_0.isNewStage = arg_2_1.isNewStage
	arg_2_0.currentStage = arg_2_1.currentStage
	arg_2_0.permanentUnlock = arg_2_1.isUnlock
	arg_2_0.isReceiveAllBonus = arg_2_1.isReceiveAllBonus
	arg_2_0.config = ActivityConfig.instance:getActivityCo(arg_2_0.id)
end

function var_0_0.getRealStartTimeStamp(arg_3_0)
	return arg_3_0.startTime / 1000
end

function var_0_0.getRealEndTimeStamp(arg_4_0)
	return arg_4_0.endTime / 1000
end

function var_0_0.isUnlock(arg_5_0)
	local var_5_0 = arg_5_0.config and arg_5_0.config.openId

	if var_5_0 and var_5_0 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_5_0) then
		return false
	end

	return true
end

function var_0_0.isOnline(arg_6_0)
	return arg_6_0.online
end

function var_0_0.isNewStageOpen(arg_7_0)
	return arg_7_0.isNewStage
end

function var_0_0.getCurrentStage(arg_8_0)
	return arg_8_0.currentStage
end

function var_0_0.isOpen(arg_9_0)
	return ServerTime.now() - arg_9_0:getRealStartTimeStamp() >= 0
end

function var_0_0.isExpired(arg_10_0)
	return arg_10_0:getRealEndTimeStamp() - ServerTime.now() <= 0
end

function var_0_0.getStartTimeStr(arg_11_0)
	return os.date("%m/%d", arg_11_0:getRealStartTimeStamp())
end

function var_0_0.getStartTimeStr1(arg_12_0)
	return os.date("%m/%d       %H:%M", arg_12_0:getRealStartTimeStamp())
end

function var_0_0.getEndTimeStr(arg_13_0)
	return os.date("%m/%d", arg_13_0:getRealEndTimeStamp())
end

function var_0_0.getEndTimeStr1(arg_14_0)
	return os.date("%m/%d       %H:%M", arg_14_0:getRealEndTimeStamp())
end

function var_0_0.getRemainTimeStr(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getRealEndTimeStamp() - ServerTime.now()
	local var_15_1, var_15_2 = TimeUtil.secondToRoughTime(var_15_0, arg_15_1)

	return var_15_1 .. var_15_2
end

function var_0_0.getRemainTimeStr2(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2 and TimeUtil.DateEnFormat.Day or luaLang("time_day")
	local var_16_1 = arg_16_2 and TimeUtil.DateEnFormat.Hour or luaLang("time_hour2")
	local var_16_2 = arg_16_2 and TimeUtil.DateEnFormat.Minute or luaLang("time_minute2")

	if not arg_16_1 or arg_16_1 <= 0 then
		return 0 .. var_16_2
	end

	arg_16_1 = math.floor(arg_16_1)

	local var_16_3 = Mathf.Floor(arg_16_1 / TimeUtil.OneDaySecond)

	if var_16_3 > 0 then
		return var_16_3 .. var_16_0
	end

	local var_16_4 = arg_16_1 % TimeUtil.OneDaySecond
	local var_16_5 = Mathf.Floor(var_16_4 / TimeUtil.OneHourSecond)

	if var_16_5 > 0 then
		return var_16_5 .. var_16_1
	end

	local var_16_6 = var_16_4 % TimeUtil.OneHourSecond
	local var_16_7 = Mathf.Floor(var_16_6 / TimeUtil.OneMinuteSecond)

	if var_16_7 <= 0 then
		var_16_7 = "<1"
	end

	return var_16_7 .. var_16_2
end

function var_0_0.getRemainTimeStr3(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getRealEndTimeStamp() - ServerTime.now()

	if not var_17_0 or var_17_0 <= 0 then
		return "<1", true
	end

	local var_17_1
	local var_17_2 = Mathf.Floor(var_17_0 / TimeUtil.OneDaySecond)
	local var_17_3 = var_17_0 % TimeUtil.OneDaySecond
	local var_17_4 = Mathf.Floor(var_17_3 / TimeUtil.OneHourSecond)
	local var_17_5 = var_17_3 % TimeUtil.OneHourSecond
	local var_17_6 = Mathf.Floor(var_17_5 / TimeUtil.OneMinuteSecond)

	if var_17_2 > 0 then
		var_17_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_17_2,
			var_17_4
		})
	elseif arg_17_2 then
		var_17_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			var_17_4,
			var_17_6
		})
	elseif var_17_4 > 0 then
		var_17_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("hour_num"), {
			var_17_4
		})
	else
		if var_17_6 <= 0 then
			var_17_6 = "<1"
		end

		var_17_1 = GameUtil.getSubPlaceholderLuaLang(luaLang("minute_num"), {
			var_17_6
		})
	end

	return var_17_1, false
end

function var_0_0.getRemainTimeStr4(arg_18_0, arg_18_1)
	if not arg_18_1 or arg_18_1 <= 0 then
		return
	end

	arg_18_1 = math.floor(arg_18_1)

	local var_18_0 = Mathf.Floor(arg_18_1 / TimeUtil.OneDaySecond)
	local var_18_1 = arg_18_1 % TimeUtil.OneDaySecond
	local var_18_2 = Mathf.Floor(var_18_1 / TimeUtil.OneHourSecond)

	if var_18_0 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			var_18_0,
			var_18_2
		})
	end

	if var_18_2 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("hour_num"), {
			var_18_2
		})
	end

	local var_18_3 = var_18_1 % TimeUtil.OneHourSecond
	local var_18_4 = Mathf.Ceil(var_18_3 / TimeUtil.OneMinuteSecond)

	if var_18_4 == 59 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("hour_num"), {
			1
		})
	else
		return GameUtil.getSubPlaceholderLuaLang(luaLang("minute_num"), {
			var_18_4
		})
	end
end

function var_0_0.getRemainTimeStr2ByOpenTime(arg_19_0)
	return arg_19_0:getRemainTimeStr2(arg_19_0:getRealStartTimeStamp() - ServerTime.now())
end

function var_0_0.getRemainTimeStr2ByEndTime(arg_20_0, arg_20_1)
	return arg_20_0:getRemainTimeStr2(arg_20_0:getRealEndTimeStamp() - ServerTime.now(), arg_20_1)
end

function var_0_0.getRemainTime(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getRealEndTimeStamp() - ServerTime.now()
	local var_21_1, var_21_2 = TimeUtil.secondToRoughTime(var_21_0, arg_21_1)

	return var_21_1, var_21_2
end

function var_0_0.getRemainDay(arg_22_0)
	local var_22_0 = arg_22_0:getRealEndTimeStamp() - ServerTime.now()

	return TimeUtil.secondsToDDHHMMSS(var_22_0)
end

function var_0_0.getRemainOpeningDay(arg_23_0)
	local var_23_0 = arg_23_0:getRealStartTimeStamp() - ServerTime.now()

	return TimeUtil.secondsToDDHHMMSS(var_23_0)
end

function var_0_0.getOpeningDay(arg_24_0)
	local var_24_0 = ServerTime.now() - arg_24_0:getRealStartTimeStamp()

	return TimeUtil.secondsToDDHHMMSS(var_24_0)
end

function var_0_0.isPermanentUnlock(arg_25_0)
	return arg_25_0.permanentUnlock
end

function var_0_0.setPermanentUnlock(arg_26_0)
	arg_26_0.permanentUnlock = true
end

return var_0_0
