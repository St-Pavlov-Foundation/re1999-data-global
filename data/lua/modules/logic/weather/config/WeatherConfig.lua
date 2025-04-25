module("modules.logic.weather.config.WeatherConfig", package.seeall)

slot0 = class("WeatherConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"weather_month",
		"weather_week",
		"weather_report",
		"skin_weather_param",
		"scene_eggs",
		"weather_day_new",
		"scene_mat_report_settings"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "weather_day_new" then
		slot0:_initWeatherDayNew()
	elseif slot1 == "scene_mat_report_settings" then
		slot0:_initSceneMatReportSettings()
	end
end

function slot0._initSceneMatReportSettings(slot0)
	slot0._sceneMatReportSettings = {}

	for slot4, slot5 in ipairs(lua_scene_mat_report_settings.configList) do
		slot0._sceneMatReportSettings[slot5.sceneId] = slot0._sceneMatReportSettings[slot5.sceneId] or {}
		slot0._sceneMatReportSettings[slot5.sceneId][slot5.mat] = slot0._sceneMatReportSettings[slot5.sceneId][slot5.mat] or {}

		for slot10, slot11 in ipairs(GameUtil.splitString2(slot5.lightmap, false, "|", "#")) do
			if lua_weather_report.configDict[tonumber(slot11[1])] then
				slot0._sceneMatReportSettings[slot5.sceneId][slot5.mat][slot13.lightMode] = slot11[2]
			else
				print("WeatherConfig:_initSceneMatReportSettings error reportId:", slot12)
			end
		end
	end
end

function slot0.getMatReportSettings(slot0, slot1)
	return slot0._sceneMatReportSettings[slot1]
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

function slot0.getDay(slot0, slot1, slot2, slot3)
	if not slot2 then
		slot4, slot1 = slot0:getWeek(slot1)
		slot9 = string.split(slot4["day" .. slot0:getNowDate().wday], "#")
		slot2 = tonumber(slot9[math.random(#slot9)])
	end

	if not (slot3 and lua_weather_day_new.configDict[slot3]) then
		logError(string.format("WeatherConfig:getDay error, sceneId:%s", slot3))

		slot4 = lua_weather_day_new.configDict[MainSceneSwitchEnum.DefaultScene]
	end

	return slot4[slot2], slot1, slot2
end

function slot0._initWeatherDayNew(slot0)
	slot0._sceneReportDict = {}

	for slot4, slot5 in ipairs(lua_weather_day_new.configList) do
		slot0._sceneReportDict[slot5.sceneId] = slot0._sceneReportDict[slot5.sceneId] or {}
		slot11 = "#"

		for slot11, slot12 in ipairs(GameUtil.splitString2(slot5.reportList, false, "|", slot11)) do
			slot0._sceneReportDict[slot5.sceneId][tonumber(slot12[2])] = true
		end
	end
end

function slot0.sceneContainReport(slot0, slot1, slot2)
	return slot0._sceneReportDict[slot1] and slot3[slot2]
end

function slot0.getReport(slot0, slot1)
	return lua_weather_report.configDict[slot1]
end

function slot0.getReportList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(lua_weather_report.configList) do
		if slot8.lightMode == slot1 and slot0:sceneContainReport(slot2, slot8.id) then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getRandomReport(slot0, slot1, slot2)
	slot3 = slot0:getReportList(slot1, slot2)

	return slot3[math.random(#slot3)]
end

function slot0.getSkinWeatherParam(slot0, slot1)
	return lua_skin_weather_param.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
