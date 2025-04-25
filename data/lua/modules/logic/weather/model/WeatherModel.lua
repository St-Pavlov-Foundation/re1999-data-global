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

function slot0._initDay(slot0, slot1)
	slot3, slot4 = nil

	if LuaUtil.isEmptyStr(PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.Weather)) == false then
		slot7 = string.split(slot6, "#")
		slot3 = tonumber(slot7[2])
		slot4 = tonumber(slot7[3])

		if slot0:getZeroTime() ~= tonumber(slot7[1]) then
			if slot0:getWeekYday(slot0:getNowDate()) ~= slot0:getWeekYday(os.date("*t", slot8)) then
				slot3 = nil
			end

			slot4 = nil
		end
	end

	slot0._curDayCo, slot0._newWeekId, slot0._newDayId = WeatherConfig.instance:getDay(slot3, slot4, slot1)

	if slot0._curDayCo.sceneId ~= slot1 then
		logError(string.format("WeatherModel:_initDay sceneId error result:%s param:%s", slot0._curDayCo.sceneId, slot1))
	end

	if slot0._newDayId ~= slot4 then
		PlayerRpc.instance:sendSetSimplePropertyRequest(slot5, string.format("%s#%s#%s", slot2, slot0._newWeekId, slot0._newDayId))
	end
end

function slot0.debug(slot0, slot1, slot2)
	return string.format("WeatherModel weekId:%s,dayId:%s,reportId:%s,sceneId:%s", slot0._newWeekId, slot0._newDayId, slot1, slot2)
end

function slot0.initDay(slot0, slot1)
	if not slot1 then
		logError("WeatherModel:initDay sceneId nil")

		slot1 = MainSceneSwitchEnum.DefaultScene
	end

	if slot0._curDayCo and slot0._curDayCo.sceneId == slot1 then
		return
	end

	slot0:_initDay(slot1)

	slot3 = string.split(slot0._curDayCo.reportList, "|")
	slot0._reportList = {}

	for slot9, slot10 in ipairs(slot3) do
		slot12 = string.split(string.split(slot10, "#")[1], ":")
		slot14 = tonumber(slot12[2])

		if tonumber(slot12[1]) and slot14 then
			if slot9 == #slot3 then
				slot15 = slot0:getZeroTime() + (slot13 * 60 + slot14) * 60 + math.random(21600)
			end

			if WeatherConfig.instance:getReport(tonumber(slot11[2])) then
				table.insert(slot0._reportList, {
					slot15,
					slot17
				})
			end
		end
	end
end

function slot0.getReport(slot0)
	slot1, slot2 = slot0:_getReport()

	if not slot1 then
		slot0._curDayCo = nil

		slot0:initDay(slot0._curDayCo and slot0._curDayCo.sceneId or MainSceneSwitchEnum.DefaultScene)

		slot1, slot2 = uv0.instance:getReport()
	end

	if not slot1 then
		logError("WeatherModel:getReport error no report")

		return lua_weather_report.configDict[1], 3600
	end

	return slot1, slot2
end

function slot0._getReport(slot0)
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
