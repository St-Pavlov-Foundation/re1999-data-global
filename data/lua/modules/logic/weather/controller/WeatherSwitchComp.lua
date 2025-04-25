module("modules.logic.weather.controller.WeatherSwitchComp", package.seeall)

slot0 = class("WeatherSwitchComp")
slot1 = 6000
slot2 = 1
slot3 = 4

function slot0.ctor(slot0)
end

function slot0.pause(slot0)
	TaskDispatcher.cancelTask(slot0._checkReport, slot0)
end

function slot0.continue(slot0)
	TaskDispatcher.runRepeat(slot0._checkReport, slot0, 1)
end

function slot0.onSceneHide(slot0)
	slot0._isHide = true

	TaskDispatcher.cancelTask(slot0._checkReport, slot0)
end

function slot0.onSceneShow(slot0)
	if not slot0._isHide then
		return
	end

	slot0._isHide = false

	TaskDispatcher.runRepeat(slot0._checkReport, slot0, 1)
	slot0:chaneWeatherLightMode(slot0._initReport.lightMode, slot0._initReport)
end

function slot0.getLightMode(slot0)
	return slot0._lightMode
end

function slot0.getReportIndex(slot0)
	return slot0._reportIndex
end

function slot0.getReportList(slot0)
	return slot0._reportList
end

function slot0.switchPrevLightMode(slot0)
	if slot0._lightMode <= uv0 then
		return
	end

	slot0._lightMode = slot0._lightMode - 1

	slot0:chaneWeatherLightMode(slot0._lightMode)
end

function slot0.switchNextLightMode(slot0)
	if uv0 <= slot0._lightMode then
		return
	end

	slot0._lightMode = slot0._lightMode + 1

	slot0:chaneWeatherLightMode(slot0._lightMode)
end

function slot0.switchNextReport(slot0)
	slot0._reportIndex = slot0._reportIndex + 1

	if slot0._reportIndex > #slot0._reportList then
		slot0._reportIndex = 1
	end

	slot0:chaneWeatherLightMode(slot0._lightMode, slot0._reportList[slot0._reportIndex])
end

function slot0.switchReport(slot0, slot1)
	slot0._reportIndex = slot1

	slot0:chaneWeatherLightMode(slot0._lightMode, slot0._reportList[slot0._reportIndex])
end

function slot0.onInit(slot0, slot1, slot2)
	slot0._sceneId = slot1
	slot3 = lua_scene_switch.configDict[slot1]
	slot0._initReportId = slot3.initReportId
	slot0._initReport = lua_weather_report.configDict[slot0._initReportId]
	slot0._reportList = {}
	slot0._changeTime = slot3.reportSwitchTime
	slot0._weatherComp = slot2

	TaskDispatcher.runRepeat(slot0._checkReport, slot0, 1)
	slot0:chaneWeatherLightMode(slot0._initReport.lightMode, slot0._initReport)
end

function slot0.chaneWeatherLightMode(slot0, slot1, slot2)
	slot0._lightMode = slot1
	slot0._reportList = WeatherConfig.instance:getReportList(slot1, slot0._sceneId)
	slot0._reportIndex = slot2 and tabletool.indexOf(slot0._reportList, slot2) or 1

	if #slot0._reportList <= 0 then
		logError(string.format("WeatherSwitchComp:chaneWeatherLightMode reportList is empty mode:%s,sceneId:%s", slot1, slot0._sceneId))
	end

	slot0:applyReport()
end

function slot0.applyReport(slot0)
	if not slot0._reportList[slot0._reportIndex] then
		return
	end

	slot0._weatherComp:changeReportId(slot1.id, uv0)

	slot0._endTime = Time.time + slot0._changeTime

	if slot0._calback then
		slot0._calback(slot0._callbackObj)
	end
end

function slot0.addReportChangeCallback(slot0, slot1, slot2)
	slot0._calback = slot1
	slot0._callbackObj = slot2
end

function slot0.removeReportChangeCallback(slot0)
	slot0._calback = nil
	slot0._callbackObj = nil
end

function slot0._checkReport(slot0)
	if slot0._endTime and slot0._endTime <= Time.time then
		slot0._reportIndex = slot0._reportIndex + 1

		if slot0._reportIndex > #slot0._reportList then
			slot0._reportIndex = 1
		end

		slot0:applyReport()
	end
end

function slot0.onSceneClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkReport, slot0)
	slot0:removeReportChangeCallback()
end

return slot0
