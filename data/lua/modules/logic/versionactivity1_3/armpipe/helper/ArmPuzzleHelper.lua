module("modules.logic.versionactivity1_3.armpipe.helper.ArmPuzzleHelper", package.seeall)

local var_0_0 = {
	getLimitTimeStr = function()
		local var_1_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)

		if var_1_0 then
			return string.format(luaLang("activity_warmup_remain_time"), var_1_0:getRemainTimeStr())
		end

		return string.format(luaLang("activity_warmup_remain_time"), "0")
	end,
	isOpenDay = function(arg_2_0)
		local var_2_0 = ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305)
		local var_2_1 = Activity124Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act305, arg_2_0)
		local var_2_2 = 0

		if var_2_0 and var_2_1 then
			local var_2_3 = var_2_0:getRealStartTimeStamp() + (var_2_1.openDay - 1) * 24 * 60 * 60
			local var_2_4 = var_2_1.preEpisode == 0 or Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, var_2_1.preEpisode)
			local var_2_5 = ServerTime.now()

			var_2_2 = math.max(var_2_3 - var_2_5, 0)

			if not var_2_4 or var_2_2 > 0 then
				return false, var_2_2
			end
		else
			return false, -1
		end

		return true, var_2_2
	end,
	formatCdTime = function(arg_3_0)
		local var_3_0 = Mathf.Floor(arg_3_0 / TimeUtil.OneDaySecond)

		if var_3_0 > 0 then
			return string.format("%s%s", var_3_0, luaLang("time_day"))
		end

		local var_3_1 = arg_3_0 % TimeUtil.OneDaySecond
		local var_3_2 = Mathf.Floor(var_3_1 / TimeUtil.OneHourSecond)

		if var_3_2 > 0 then
			return string.format("%s%s", var_3_2, luaLang("time_hour"))
		end

		local var_3_3 = arg_3_0 % TimeUtil.OneHourSecond
		local var_3_4 = Mathf.Ceil(var_3_3 / TimeUtil.OneMinuteSecond)

		return string.format("%s%s", var_3_4, luaLang("time_minute"))
	end,
	formatCdLock = function(arg_4_0)
		local var_4_0 = Mathf.Ceil(arg_4_0 / TimeUtil.OneDaySecond)

		return formatLuaLang("versionactivity_1_2_119_unlock", math.max(0, var_4_0))
	end,
	getRotation = function(arg_5_0, arg_5_1)
		local var_5_0 = ArmPuzzlePipeEnum.rotate[arg_5_0]

		return var_5_0 and var_5_0[arg_5_1] and var_5_0[arg_5_1][1] or 0
	end,
	_getRes = function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0

		if arg_6_2 then
			local var_6_1 = arg_6_2[arg_6_0]
			local var_6_2 = var_6_1 and var_6_1[arg_6_1]

			if not string.nilorempty(var_6_2) then
				return var_6_2, true
			end
		end

		local var_6_3 = ArmPuzzlePipeEnum.res[arg_6_0]

		return var_6_3 and var_6_3[arg_6_1]
	end
}

function var_0_0.getBackgroundRes(arg_7_0, arg_7_1)
	return var_0_0._getRes(arg_7_0, 1, arg_7_1)
end

function var_0_0.getConnectRes(arg_8_0, arg_8_1)
	return var_0_0._getRes(arg_8_0, 2, arg_8_1)
end

return var_0_0
