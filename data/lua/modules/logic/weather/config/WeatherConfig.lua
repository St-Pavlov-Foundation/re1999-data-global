module("modules.logic.weather.config.WeatherConfig", package.seeall)

slot0 = class("WeatherConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"weather_month",
		"weather_week",
		"weather_day",
		"weather_report",
		"skin_weather_param"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getNowDate(slot0)
	return os.date("*t", os.time())
end

function slot0.getWeek(slot0, slot1)
	if not slot1 then
		slot6 = string.split(lua_weather_month.configDict[slot0:getNowDate().month].weekList, "#")
		slot1 = tonumber(slot6[math.random(#slot6)])
	end

	return lua_weather_week.configDict[slot1], slot1
end

function slot0.getDay(slot0, slot1, slot2)
	if not slot2 then
		slot3, slot1 = slot0:getWeek(slot1)
		slot8 = string.split(slot3["day" .. slot0:getNowDate().wday], "#")
		slot2 = tonumber(slot8[math.random(#slot8)])
	end

	return lua_weather_day.configDict[slot2], slot1, slot2
end

function slot0.getReport(slot0, slot1)
	return lua_weather_report.configDict[slot1]
end

function slot0.getRandomReport(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_weather_report.configList) do
		if slot7.lightMode == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2[math.random(#slot2)]
end

function slot0.getSkinWeatherParam(slot0, slot1)
	return lua_skin_weather_param.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
