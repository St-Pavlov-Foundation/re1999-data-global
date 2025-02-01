module("modules.logic.versionactivity1_3.armpipe.helper.ArmPuzzleHelper", package.seeall)

return {
	getLimitTimeStr = function ()
		if ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305) then
			return string.format(luaLang("activity_warmup_remain_time"), slot0:getRemainTimeStr())
		end

		return string.format(luaLang("activity_warmup_remain_time"), "0")
	end,
	isOpenDay = function (slot0)
		slot2 = Activity124Config.instance:getEpisodeCo(VersionActivity1_3Enum.ActivityId.Act305, slot0)
		slot3 = 0

		if ActivityModel.instance:getActMO(VersionActivity1_3Enum.ActivityId.Act305) and slot2 then
			slot3 = math.max(slot1:getRealStartTimeStamp() + (slot2.openDay - 1) * 24 * 60 * 60 - ServerTime.now(), 0)

			if slot2.preEpisode ~= 0 and not Activity124Model.instance:isEpisodeClear(VersionActivity1_3Enum.ActivityId.Act305, slot2.preEpisode) or slot3 > 0 then
				return false, slot3
			end
		else
			return false, -1
		end

		return true, slot3
	end,
	formatCdTime = function (slot0)
		if Mathf.Floor(slot0 / TimeUtil.OneDaySecond) > 0 then
			return string.format("%s%s", slot1, luaLang("time_day"))
		end

		if Mathf.Floor(slot0 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond) > 0 then
			return string.format("%s%s", slot3, luaLang("time_hour"))
		end

		return string.format("%s%s", Mathf.Ceil(slot0 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond), luaLang("time_minute"))
	end,
	formatCdLock = function (slot0)
		return formatLuaLang("versionactivity_1_2_119_unlock", math.max(0, Mathf.Ceil(slot0 / TimeUtil.OneDaySecond)))
	end,
	getRotation = function (slot0, slot1)
		return ArmPuzzlePipeEnum.rotate[slot0] and slot2[slot1] and slot2[slot1][1] or 0
	end,
	_getRes = function (slot0, slot1, slot2)
		if slot2 and not string.nilorempty(slot2[slot0] and slot4[slot1]) then
			return nil, true
		end

		return ArmPuzzlePipeEnum.res[slot0] and slot4[slot1]
	end,
	getBackgroundRes = function (slot0, slot1)
		return uv0._getRes(slot0, 1, slot1)
	end,
	getConnectRes = function (slot0, slot1)
		return uv0._getRes(slot0, 2, slot1)
	end
}
