module("modules.logic.weather.model.WeatherModel", package.seeall)

local var_0_0 = class("WeatherModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curDayCo = nil
end

function var_0_0.getZeroTime(arg_3_0)
	local var_3_0 = arg_3_0:getNowDate()

	var_3_0.hour = 0
	var_3_0.min = 0
	var_3_0.sec = 0

	return (os.time(var_3_0))
end

function var_0_0.getWeekYday(arg_4_0, arg_4_1)
	local var_4_0 = TimeUtil.convertWday(arg_4_1.wday)

	return arg_4_1.yday - var_4_0
end

function var_0_0._initDay(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getZeroTime()
	local var_5_1
	local var_5_2
	local var_5_3 = PlayerEnum.SimpleProperty.Weather
	local var_5_4 = PlayerModel.instance:getSimpleProperty(var_5_3)

	if LuaUtil.isEmptyStr(var_5_4) == false then
		local var_5_5 = string.split(var_5_4, "#")
		local var_5_6 = tonumber(var_5_5[1])

		var_5_1 = tonumber(var_5_5[2])
		var_5_2 = tonumber(var_5_5[3])

		if var_5_0 ~= var_5_6 then
			local var_5_7 = arg_5_0:getNowDate()
			local var_5_8 = os.date("*t", var_5_6)

			if arg_5_0:getWeekYday(var_5_7) ~= arg_5_0:getWeekYday(var_5_8) then
				var_5_1 = nil
			end

			var_5_2 = nil
		end
	end

	arg_5_0._curDayCo, arg_5_0._newWeekId, arg_5_0._newDayId = WeatherConfig.instance:getDay(var_5_1, var_5_2, arg_5_1)

	if arg_5_0._curDayCo.sceneId ~= arg_5_1 then
		logError(string.format("WeatherModel:_initDay sceneId error result:%s param:%s", arg_5_0._curDayCo.sceneId, arg_5_1))
	end

	if arg_5_0._newDayId ~= var_5_2 then
		local var_5_9 = string.format("%s#%s#%s", var_5_0, arg_5_0._newWeekId, arg_5_0._newDayId)

		PlayerRpc.instance:sendSetSimplePropertyRequest(var_5_3, var_5_9)
	end
end

function var_0_0.debug(arg_6_0, arg_6_1, arg_6_2)
	return string.format("WeatherModel weekId:%s,dayId:%s,reportId:%s,sceneId:%s", arg_6_0._newWeekId, arg_6_0._newDayId, arg_6_1, arg_6_2)
end

function var_0_0.initDay(arg_7_0, arg_7_1)
	if not arg_7_1 then
		logError("WeatherModel:initDay sceneId nil")

		arg_7_1 = MainSceneSwitchEnum.DefaultScene
	end

	if arg_7_0._curDayCo and arg_7_0._curDayCo.sceneId == arg_7_1 then
		return
	end

	arg_7_0:_initDay(arg_7_1)

	local var_7_0 = arg_7_0._curDayCo.reportList
	local var_7_1 = string.split(var_7_0, "|")
	local var_7_2 = #var_7_1

	arg_7_0._reportList = {}

	local var_7_3 = arg_7_0:getZeroTime()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_4 = string.split(iter_7_1, "#")
		local var_7_5 = string.split(var_7_4[1], ":")
		local var_7_6 = tonumber(var_7_5[1])
		local var_7_7 = tonumber(var_7_5[2])

		if var_7_6 and var_7_7 then
			local var_7_8 = var_7_3 + (var_7_6 * 60 + var_7_7) * 60

			if iter_7_0 == var_7_2 then
				var_7_8 = var_7_8 + math.random(21600)
			end

			local var_7_9 = tonumber(var_7_4[2])
			local var_7_10 = WeatherConfig.instance:getReport(var_7_9)

			if var_7_10 then
				table.insert(arg_7_0._reportList, {
					var_7_8,
					var_7_10
				})
			end
		end
	end
end

function var_0_0.getReport(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:_getReport()

	if not var_8_0 then
		local var_8_2 = arg_8_0._curDayCo and arg_8_0._curDayCo.sceneId or MainSceneSwitchEnum.DefaultScene

		arg_8_0._curDayCo = nil

		arg_8_0:initDay(var_8_2)

		var_8_0, var_8_1 = var_0_0.instance:getReport()
	end

	if not var_8_0 then
		logError("WeatherModel:getReport error no report")

		return lua_weather_report.configDict[1], 3600
	end

	return var_8_0, var_8_1
end

function var_0_0._getReport(arg_9_0)
	local var_9_0 = os.time()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._reportList) do
		local var_9_1 = iter_9_1[1]

		if var_9_0 < var_9_1 then
			return iter_9_1[2], var_9_1 - var_9_0
		end
	end
end

function var_0_0.getNowDate(arg_10_0)
	return WeatherConfig.instance:getNowDate()
end

var_0_0.instance = var_0_0.New()

return var_0_0
