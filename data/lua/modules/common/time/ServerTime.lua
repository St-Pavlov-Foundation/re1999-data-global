module("modules.common.time.ServerTime", package.seeall)

slot0 = _M
slot1 = 0
slot2 = 0
slot3 = 0
slot4 = os.time()
slot5 = 0

function slot0.init(slot0)
	uv0 = slot0 or uv1.getInitServerUtcOffset()
	uv2 = os.difftime(os.time(), os.time(os.date("!*t", os.time())))
	uv3 = uv0 - uv2
end

function slot0.getInitServerUtcOffset()
	slot0 = GameConfig:GetCurRegionType()

	if RegionEnum and RegionEnum.utcOffset[slot0] then
		return RegionEnum.utcOffset[slot0]
	else
		return ModuleEnum.ServerUtcOffset
	end
end

function slot0.clientToServerOffset()
	return uv0
end

function slot0.update(slot0)
	uv0 = slot0
	uv1 = Time.realtimeSinceStartup
end

function slot0.now()
	return uv1 + math.floor(Time.realtimeSinceStartup - uv0)
end

function slot0.nowInLocal()
	return uv0.now() + uv1 + uv0.getDstOffset()
end

function slot0.timeInLocal(slot0)
	return slot0 + uv0 + uv1.getDstOffset()
end

function slot0.nowDate()
	return os.date("*t", uv0.now())
end

function slot0.nowDateInLocal()
	return os.date("*t", uv0.nowInLocal())
end

function slot0.weekDayInServerLocal()
	return TimeUtil.convertWday(os.date("*t", uv0.nowInLocal() - 18000).wday)
end

function slot0.timeDateInLocal(slot0)
	return os.date("*t", uv0.timeInLocal(slot0))
end

function slot0.formatNow(slot0)
	return os.date(slot0, uv0.now())
end

function slot0.serverUtcOffset()
	return uv0
end

function slot0.formatNowInLocal(slot0)
	return os.date(slot0, uv0.nowInLocal())
end

function slot0.formatTimeInLocal(slot0, slot1)
	return os.date(slot1, uv0.timeInLocal(slot0))
end

function slot0.getDstOffset()
	return os.date("*t", os.time()).isdst and -3600 or 0
end

function slot0.timestampToString(slot0)
	return os.date("%Y-%m-%d %H:%M:%S", slot0 + uv0 + uv1.getDstOffset())
end

function slot0.ReplaceUTCStr(slot0)
	if slot0 then
		return string.gsub(slot0, "UTC%+8", uv0.GetUTCOffsetStr())
	else
		return ""
	end
end

function slot0.getServerTimeToday(slot0)
	if slot0 then
		slot1 = uv0.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	end

	return tonumber(os.date("%d", slot1))
end

function slot0.getToadyEndTimeStamp(slot0)
	if slot0 then
		slot2 = uv0.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	end

	slot3 = os.date("*t", slot2)

	if slot0 then
		slot4 = os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = slot3.year,
			month = slot3.month,
			day = slot3.day
		}) + slot1
	end

	return slot4 + 1
end

function slot0.getWeekEndTimeStamp(slot0)
	slot4 = true

	if TimeUtil.getTodayWeedDay(uv0.nowDateInLocal()) == 1 and slot0 and TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond > slot2.hour * 3600 + slot2.min * 60 + slot2.sec then
		slot4 = false
	end

	slot5 = nil

	if not slot4 then
		slot5 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = slot2.year,
			month = slot2.month,
			day = slot2.day
		}
	else
		slot7 = slot2.day + 7 - slot3 + 1

		if slot2.month == 2 then
			if slot7 > 29 and (slot2.year % 400 == 0 or slot2.year % 4 == 0 and slot2.year % 100 ~= 0) then
				slot8 = slot8 + 1
				slot7 = slot7 - 29
			elseif slot7 > 28 then
				slot8 = slot8 + 1
				slot7 = slot7 - 28
			end
		elseif slot8 == 4 or slot8 == 6 or slot8 == 9 or slot8 == 11 then
			if slot7 > 30 then
				slot8 = slot8 + 1
				slot7 = slot7 - 30
			end
		elseif slot7 > 31 then
			slot8 = slot8 + 1
			slot7 = slot7 - 31
		end

		if slot8 > 12 then
			slot9 = slot9 + 1
			slot8 = slot8 - 12
		end

		slot5 = {
			hour = 0,
			min = 0,
			sec = 0,
			year = slot9,
			month = slot8,
			day = slot7
		}
	end

	if slot0 then
		slot6 = os.time(slot5) + slot1
	end

	return uv0.clientTs2ServerTs(slot6)
end

function slot0.getMonthEndTimeStamp(slot0)
	slot3 = true

	if uv0.nowDateInLocal().day == 1 and slot0 and TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond > slot2.hour * 3600 + slot2.min * 60 + slot2.sec then
		slot3 = false
	end

	if slot3 then
		if slot2.month == 12 then
			slot2.year = slot2.year + 1
			slot2.month = 1
		else
			slot2.month = slot2.month + 1
		end
	end

	if slot0 then
		slot5 = os.time({
			hour = 0,
			min = 0,
			sec = 0,
			day = 1,
			year = slot2.year,
			month = slot2.month
		}) + slot1
	end

	return uv0.clientTs2ServerTs(slot5)
end

function slot0.clientTs2ServerTs(slot0)
	return slot0 - uv0.clientToServerOffset() - uv0.getDstOffset()
end

function slot0.GetUTCOffsetStr()
	return string.format("UTC%+d", uv0 / 3600)
end

return slot0
