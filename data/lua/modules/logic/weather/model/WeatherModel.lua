module("modules.logic.weather.model.WeatherModel", package.seeall)

slot0 = class("WeatherModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0._curDayCo = nil
end

function slot0.getZeroTime(slot0)
	slot1 = slot0:getNowDate()
	slot1.hour = 0
	slot1.min = 0
	slot1.sec = 0

	return os.time(slot1)
end

function slot0.getWeekYday(slot0, slot1)
	return slot1.yday - TimeUtil.convertWday(slot1.wday)
end

function slot0._initDay(slot0)
	slot2, slot3 = nil

	if LuaUtil.isEmptyStr(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.Weather)) == false then
		slot6 = string.split(slot5, "#")
		slot2 = tonumber(slot6[2])
		slot3 = tonumber(slot6[3])

		if slot0:getZeroTime() ~= tonumber(slot6[1]) then
			if slot0:getWeekYday(slot0:getNowDate()) ~= slot0:getWeekYday(os.date("*t", slot7)) then
				slot2 = nil
			end

			slot3 = nil
		end
	end

	slot0._curDayCo, slot0._newWeekId, slot0._newDayId = WeatherConfig.instance:getDay(slot2, slot3)

	if slot0._newDayId ~= slot3 then
		PlayerRpc.instance:sendSetSimplePropertyRequest(slot4, string.format("%s#%s#%s", slot1, slot0._newWeekId, slot0._newDayId))
	end
end

function slot0.debug(slot0, slot1)
	return string.format("WeatherModel weekId:%s,dayId:%s,reportId:%s", slot0._newWeekId, slot0._newDayId, slot1)
end

function slot0.resetDay(slot0)
	slot0._curDayCo = nil

	slot0:initDay()
end

function slot0.initDay(slot0)
	if slot0._curDayCo then
		return
	end

	slot0:_initDay()

	slot2 = string.split(slot0._curDayCo.reportList, "|")
	slot0._reportList = {}

	for slot8, slot9 in ipairs(slot2) do
		slot11 = string.split(string.split(slot9, "#")[1], ":")
		slot13 = tonumber(slot11[2])

		if tonumber(slot11[1]) and slot13 then
			if slot8 == #slot2 then
				slot14 = slot0:getZeroTime() + (slot12 * 60 + slot13) * 60 + math.random(21600)
			end

			if WeatherConfig.instance:getReport(tonumber(slot10[2])) then
				table.insert(slot0._reportList, {
					slot14,
					slot16
				})
			end
		end
	end
end

function slot0.getReport(slot0)
	slot1 = os.time()

	for slot5, slot6 in ipairs(slot0._reportList) do
		if slot1 < slot6[1] then
			return slot6[2], slot7 - slot1
		end
	end
end

function slot0.getNowDate(slot0)
	return WeatherConfig.instance:getNowDate()
end

slot0.instance = slot0.New()

return slot0
