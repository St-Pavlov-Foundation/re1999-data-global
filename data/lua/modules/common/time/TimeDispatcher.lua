module("modules.common.time.TimeDispatcher", package.seeall)

slot0 = class("TimeDispatcher")
slot0.OnHour = "OnHour"
slot0.OnDay = "OnDay"
slot0.OnWeek = "OnWeek"
slot0.OnDailyRefresh = "OnDailyRefresh"
slot0.CheckInterval = 5
slot0.DailyRefreshTime = 5
slot0.DailyRefreshSecond = slot0.DailyRefreshTime * 3600

function slot0.ctor(slot0)
	LuaEventSystem.addEventMechanism(slot0)

	slot0._lastCheckYear = -1
	slot0._lastCheckYDay = -1
	slot0._lastCheckHour = -1
	slot0._lastCheckWDay = -1
	slot0._lastCheckStamp = -1
	slot0._year = 0
	slot0._yday = 0
	slot0._wday = 0
	slot0._hour = 0
	slot0._stamp = 0
end

function slot0.startTick(slot0)
	slot0:_check(true)
	TaskDispatcher.runRepeat(slot0._check, slot0, uv0.CheckInterval)
end

function slot0.stopTick(slot0)
	TaskDispatcher.cancelTask(slot0._check, slot0)

	slot0._lastCheckYear = -1
	slot0._lastCheckYDay = -1
	slot0._lastCheckHour = -1
	slot0._lastCheckWDay = -1
	slot0._lastCheckStamp = -1
end

function slot0._check(slot0, slot1)
	slot0._stamp = ServerTime.nowInLocal()
	slot2 = os.date("*t", slot0._stamp)
	slot0._year = slot2.year
	slot0._wday = slot2.wday

	if slot0._wday == 1 then
		slot0._wday = 8
	end

	slot0._yday = slot2.yday
	slot0._hour = slot2.hour

	if slot0:_checkHour() and not slot1 then
		slot0:dispatchEvent(uv0.OnHour)

		if slot0:_checkRefreshTime() then
			slot0:dispatchEvent(uv0.OnDailyRefresh)
		end

		if slot0:_checkDay() then
			slot0:dispatchEvent(uv0.OnDay)

			if slot0:_checkWeek() then
				slot0:dispatchEvent(uv0.OnWeek)
			end
		end
	end

	slot0._lastCheckYear = slot0._year
	slot0._lastCheckYDay = slot0._yday
	slot0._lastCheckHour = slot0._hour
	slot0._lastCheckWDay = slot0._wday
	slot0._lastCheckStamp = slot0._stamp
end

function slot0._checkHour(slot0)
	if slot0._lastCheckYear < 0 then
		return false
	elseif slot0._lastCheckYear == slot0._year and slot0._lastCheckYDay == slot0._yday and slot0._lastCheckHour == slot0._hour then
		return false
	end

	return true
end

function slot0._checkRefreshTime(slot0)
	if slot0._hour == uv0.DailyRefreshTime then
		return true
	end

	return false
end

function slot0._checkDay(slot0)
	if slot0._lastCheckYear < 0 then
		return false
	elseif slot0._lastCheckYear == slot0._year and slot0._lastCheckYDay == slot0._yday then
		return false
	end

	return true
end

function slot0._checkWeek(slot0)
	if slot0._lastCheckStamp < 0 then
		return false
	elseif slot0._stamp - slot0._lastCheckStamp < 604800 and slot0._lastCheckWDay <= slot0._wday then
		return false
	end

	return true
end

slot0.instance = slot0.New()

return slot0
