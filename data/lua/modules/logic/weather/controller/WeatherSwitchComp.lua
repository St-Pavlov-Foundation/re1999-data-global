module("modules.logic.weather.controller.WeatherSwitchComp", package.seeall)

local var_0_0 = class("WeatherSwitchComp")
local var_0_1 = 6000
local var_0_2 = 1
local var_0_3 = 4

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.pause(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._checkReport, arg_2_0)
end

function var_0_0.continue(arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0._checkReport, arg_3_0, 1)
end

function var_0_0.onSceneHide(arg_4_0)
	arg_4_0._isHide = true

	TaskDispatcher.cancelTask(arg_4_0._checkReport, arg_4_0)
end

function var_0_0.onSceneShow(arg_5_0)
	if not arg_5_0._isHide then
		return
	end

	arg_5_0._isHide = false

	TaskDispatcher.runRepeat(arg_5_0._checkReport, arg_5_0, 1)
	arg_5_0:chaneWeatherLightMode(arg_5_0._initReport.lightMode, arg_5_0._initReport)
end

function var_0_0.getLightMode(arg_6_0)
	return arg_6_0._lightMode
end

function var_0_0.getReportIndex(arg_7_0)
	return arg_7_0._reportIndex
end

function var_0_0.getReportList(arg_8_0)
	return arg_8_0._reportList
end

function var_0_0.switchPrevLightMode(arg_9_0)
	if arg_9_0._lightMode <= var_0_2 then
		return
	end

	arg_9_0._lightMode = arg_9_0._lightMode - 1

	arg_9_0:chaneWeatherLightMode(arg_9_0._lightMode)
end

function var_0_0.switchNextLightMode(arg_10_0)
	if arg_10_0._lightMode >= var_0_3 then
		return
	end

	arg_10_0._lightMode = arg_10_0._lightMode + 1

	arg_10_0:chaneWeatherLightMode(arg_10_0._lightMode)
end

function var_0_0.switchNextReport(arg_11_0)
	arg_11_0._reportIndex = arg_11_0._reportIndex + 1

	if arg_11_0._reportIndex > #arg_11_0._reportList then
		arg_11_0._reportIndex = 1
	end

	arg_11_0:chaneWeatherLightMode(arg_11_0._lightMode, arg_11_0._reportList[arg_11_0._reportIndex])
end

function var_0_0.switchReport(arg_12_0, arg_12_1)
	arg_12_0._reportIndex = arg_12_1

	arg_12_0:chaneWeatherLightMode(arg_12_0._lightMode, arg_12_0._reportList[arg_12_0._reportIndex])
end

function var_0_0.onInit(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._sceneId = arg_13_1

	local var_13_0 = lua_scene_switch.configDict[arg_13_1]

	arg_13_0._initReportId = var_13_0.initReportId
	arg_13_0._initReport = lua_weather_report.configDict[arg_13_0._initReportId]
	arg_13_0._reportList = {}
	arg_13_0._changeTime = var_13_0.reportSwitchTime
	arg_13_0._weatherComp = arg_13_2

	TaskDispatcher.runRepeat(arg_13_0._checkReport, arg_13_0, 1)
	arg_13_0:chaneWeatherLightMode(arg_13_0._initReport.lightMode, arg_13_0._initReport)
end

function var_0_0.chaneWeatherLightMode(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._lightMode = arg_14_1
	arg_14_0._reportList = WeatherConfig.instance:getReportList(arg_14_1, arg_14_0._sceneId)
	arg_14_0._reportIndex = arg_14_2 and tabletool.indexOf(arg_14_0._reportList, arg_14_2) or 1

	if #arg_14_0._reportList <= 0 then
		logError(string.format("WeatherSwitchComp:chaneWeatherLightMode reportList is empty mode:%s,sceneId:%s", arg_14_1, arg_14_0._sceneId))
	end

	arg_14_0:applyReport()
end

function var_0_0.applyReport(arg_15_0)
	local var_15_0 = arg_15_0._reportList[arg_15_0._reportIndex]

	if not var_15_0 then
		return
	end

	arg_15_0._weatherComp:changeReportId(var_15_0.id, var_0_1)

	arg_15_0._endTime = Time.time + arg_15_0._changeTime

	if arg_15_0._calback then
		arg_15_0._calback(arg_15_0._callbackObj)
	end
end

function var_0_0.addReportChangeCallback(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._calback = arg_16_1
	arg_16_0._callbackObj = arg_16_2
end

function var_0_0.removeReportChangeCallback(arg_17_0)
	arg_17_0._calback = nil
	arg_17_0._callbackObj = nil
end

function var_0_0._checkReport(arg_18_0)
	if arg_18_0._endTime and Time.time >= arg_18_0._endTime then
		arg_18_0._reportIndex = arg_18_0._reportIndex + 1

		if arg_18_0._reportIndex > #arg_18_0._reportList then
			arg_18_0._reportIndex = 1
		end

		arg_18_0:applyReport()
	end
end

function var_0_0.onSceneClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._checkReport, arg_19_0)
	arg_19_0:removeReportChangeCallback()
end

return var_0_0
