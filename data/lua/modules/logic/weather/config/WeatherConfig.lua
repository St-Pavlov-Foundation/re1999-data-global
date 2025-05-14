module("modules.logic.weather.config.WeatherConfig", package.seeall)

local var_0_0 = class("WeatherConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
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

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "weather_day_new" then
		arg_3_0:_initWeatherDayNew()
	elseif arg_3_1 == "scene_mat_report_settings" then
		arg_3_0:_initSceneMatReportSettings()
	end
end

function var_0_0._initSceneMatReportSettings(arg_4_0)
	arg_4_0._sceneMatReportSettings = {}

	for iter_4_0, iter_4_1 in ipairs(lua_scene_mat_report_settings.configList) do
		local var_4_0 = GameUtil.splitString2(iter_4_1.lightmap, false, "|", "#")

		arg_4_0._sceneMatReportSettings[iter_4_1.sceneId] = arg_4_0._sceneMatReportSettings[iter_4_1.sceneId] or {}
		arg_4_0._sceneMatReportSettings[iter_4_1.sceneId][iter_4_1.mat] = arg_4_0._sceneMatReportSettings[iter_4_1.sceneId][iter_4_1.mat] or {}

		for iter_4_2, iter_4_3 in ipairs(var_4_0) do
			local var_4_1 = tonumber(iter_4_3[1])
			local var_4_2 = lua_weather_report.configDict[var_4_1]

			if var_4_2 then
				arg_4_0._sceneMatReportSettings[iter_4_1.sceneId][iter_4_1.mat][var_4_2.lightMode] = iter_4_3[2]
			else
				print("WeatherConfig:_initSceneMatReportSettings error reportId:", var_4_1)
			end
		end
	end
end

function var_0_0.getMatReportSettings(arg_5_0, arg_5_1)
	return arg_5_0._sceneMatReportSettings[arg_5_1]
end

function var_0_0.getNowDate(arg_6_0)
	return os.date("*t", os.time())
end

function var_0_0.getWeek(arg_7_0, arg_7_1)
	if not arg_7_1 then
		local var_7_0 = arg_7_0:getNowDate().month
		local var_7_1 = lua_weather_month.configDict[var_7_0].weekList
		local var_7_2 = string.split(var_7_1, "#")
		local var_7_3 = math.random(#var_7_2)

		arg_7_1 = tonumber(var_7_2[var_7_3])
	end

	return lua_weather_week.configDict[arg_7_1], arg_7_1
end

function var_0_0.getDay(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_2 then
		local var_8_0, var_8_1 = arg_8_0:getWeek(arg_8_1)

		arg_8_1 = var_8_1

		local var_8_2 = arg_8_0:getNowDate().wday
		local var_8_3 = var_8_0["day" .. var_8_2]
		local var_8_4 = string.split(var_8_3, "#")

		arg_8_2 = tonumber(var_8_4[math.random(#var_8_4)])
	end

	local var_8_5 = arg_8_3 and lua_weather_day_new.configDict[arg_8_3]

	if not var_8_5 then
		logError(string.format("WeatherConfig:getDay error, sceneId:%s", arg_8_3))

		var_8_5 = lua_weather_day_new.configDict[MainSceneSwitchEnum.DefaultScene]
	end

	return var_8_5[arg_8_2], arg_8_1, arg_8_2
end

function var_0_0._initWeatherDayNew(arg_9_0)
	arg_9_0._sceneReportDict = {}

	for iter_9_0, iter_9_1 in ipairs(lua_weather_day_new.configList) do
		arg_9_0._sceneReportDict[iter_9_1.sceneId] = arg_9_0._sceneReportDict[iter_9_1.sceneId] or {}

		local var_9_0 = arg_9_0._sceneReportDict[iter_9_1.sceneId]
		local var_9_1 = GameUtil.splitString2(iter_9_1.reportList, false, "|", "#")

		for iter_9_2, iter_9_3 in ipairs(var_9_1) do
			var_9_0[tonumber(iter_9_3[2])] = true
		end
	end
end

function var_0_0.sceneContainReport(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._sceneReportDict[arg_10_1]

	return var_10_0 and var_10_0[arg_10_2]
end

function var_0_0.getReport(arg_11_0, arg_11_1)
	return lua_weather_report.configDict[arg_11_1]
end

function var_0_0.getReportList(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(lua_weather_report.configList) do
		if iter_12_1.lightMode == arg_12_1 and arg_12_0:sceneContainReport(arg_12_2, iter_12_1.id) then
			table.insert(var_12_0, iter_12_1)
		end
	end

	return var_12_0
end

function var_0_0.getRandomReport(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getReportList(arg_13_1, arg_13_2)

	return var_13_0[math.random(#var_13_0)]
end

function var_0_0.getSkinWeatherParam(arg_14_0, arg_14_1)
	return lua_skin_weather_param.configDict[arg_14_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
