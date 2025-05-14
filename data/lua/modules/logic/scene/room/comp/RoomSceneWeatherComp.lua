module("modules.logic.scene.room.comp.RoomSceneWeatherComp", package.seeall)

local var_0_0 = class("RoomSceneWeatherComp", BaseSceneComp)

var_0_0.WeatherUpdateRate = 60
var_0_0.WeatherSwitchTime = 30

function var_0_0.onInit(arg_1_0)
	arg_1_0._lightModeParamList = {
		{
			LightIntensity = 1,
			AmbientColor = Color(0.71, 0.698, 0.647, 1),
			FogColor = Color(0.718, 0.749, 0.722, 1),
			LightColor = Color(0.612, 0.487, 0.396, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.447, 0.561, 0.596, 1),
			FogColor = Color(0.404, 0.514, 0.592, 1),
			LightColor = Color(0.6, 0.592, 0.541, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.655, 0.624, 0.58),
			FogColor = Color(0.702, 0.478, 0.388, 1),
			LightColor = Color(0.706, 0.459, 0.353, 1)
		},
		{
			LightIntensity = 1,
			AmbientColor = Color(0.314, 0.467, 0.655, 1),
			FogColor = Color(0.118, 0.31, 0.486, 1),
			LightColor = Color(0.388, 0.627, 0.757, 1)
		}
	}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._curReportConfig = nil
	arg_2_0._curReportEndTime = nil
	arg_2_0._curLightMode = nil

	if not RoomController.instance:isDebugMode() then
		arg_2_0:_initWeather()
		TaskDispatcher.runRepeat(arg_2_0._checkReport, arg_2_0, var_0_0.WeatherUpdateRate)
	end

	WeatherController.instance:registerCallback(WeatherEvent.WeatherChanged, arg_2_0._weatherChanged, arg_2_0)
end

function var_0_0.tweenLightModeParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0._tweenLightModeParamId then
		arg_3_0._scene.tween:killById(arg_3_0._tweenLightModeParamId)

		arg_3_0._tweenLightModeParamId = nil
	end

	if arg_3_3 then
		arg_3_0:_changeLightModeParam(arg_3_2)
	else
		arg_3_0._tweenLightModeParamId = arg_3_0._scene.tween:tweenFloat(0, 1, var_0_0.WeatherSwitchTime, arg_3_0._tweenLightModeFrame, arg_3_0._tweenLightModeFinish, arg_3_0, {
			preLightModeParam = arg_3_1,
			curLightModeParam = arg_3_2
		})
	end
end

function var_0_0._tweenLightModeFrame(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		AmbientColor = arg_4_2.preLightModeParam.AmbientColor:Lerp(arg_4_2.curLightModeParam.AmbientColor, arg_4_1),
		FogColor = arg_4_2.preLightModeParam.FogColor:Lerp(arg_4_2.curLightModeParam.FogColor, arg_4_1),
		LightColor = arg_4_2.preLightModeParam.LightColor:Lerp(arg_4_2.curLightModeParam.LightColor, arg_4_1),
		LightIntensity = arg_4_2.preLightModeParam.LightIntensity + (arg_4_2.curLightModeParam.LightIntensity - arg_4_2.preLightModeParam.LightIntensity) * arg_4_1
	}

	arg_4_0:_changeLightModeParam(var_4_0)
end

function var_0_0._tweenLightModeFinish(arg_5_0, arg_5_1)
	arg_5_0:_changeLightModeParam(arg_5_1.curLightModeParam)
end

function var_0_0._changeLightModeParam(arg_6_0, arg_6_1)
	return
end

function var_0_0._getLightModeParam(arg_7_0)
	return {
		AmbientColor = arg_7_0._scene.bending:getAmbientColor(),
		FogColor = arg_7_0._scene.bending:getFogColor(),
		LightColor = arg_7_0._scene.light:getLightColor(),
		LightIntensity = arg_7_0._scene.light:getLightIntensity()
	}
end

function var_0_0.setLightMode(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._curLightMode == arg_8_1 and not arg_8_2 then
		return
	end

	arg_8_0._curLightMode = arg_8_1

	local var_8_0 = arg_8_0:_getLightModeParam()
	local var_8_1 = arg_8_0._lightModeParamList[arg_8_1] or arg_8_0._lightModeParamList[#arg_8_0._lightModeParamList]

	arg_8_0:tweenLightModeParam(var_8_0, var_8_1, arg_8_2)
end

function var_0_0.setReport(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._curReportConfig == arg_9_1 and not arg_9_2 then
		return
	end

	arg_9_0._curReportConfig = arg_9_1

	local var_9_0 = arg_9_1.lightMode

	arg_9_0:setLightMode(var_9_0, arg_9_2)
end

function var_0_0._initWeather(arg_10_0)
	arg_10_0:updateReport(true)

	if not arg_10_0._curLightMode then
		arg_10_0:setLightMode(1, true)
	end
end

function var_0_0._weatherChanged(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:changeReport(arg_11_1, arg_11_2)
end

function var_0_0.changeReport(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1 and WeatherConfig.instance:getReport(arg_12_1)

	if not var_12_0 or not arg_12_2 then
		return
	end

	arg_12_0:setReport(var_12_0, arg_12_3)

	arg_12_0._curReportEndTime = ServerTime.now() + arg_12_2
end

function var_0_0.updateReport(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = arg_13_0:_getReport()

	arg_13_0:changeReport(var_13_0.id, var_13_1, arg_13_1)
end

function var_0_0._checkReport(arg_14_0)
	if arg_14_0._curReportEndTime and arg_14_0._curReportEndTime <= ServerTime.now() then
		arg_14_0:updateReport()
	end
end

function var_0_0._getReport(arg_15_0)
	local var_15_0, var_15_1 = WeatherModel.instance:getReport()

	return var_15_0, var_15_1
end

function var_0_0.onSceneClose(arg_16_0)
	if arg_16_0._tweenLightModeParamId then
		arg_16_0._scene.tween:killById(arg_16_0._tweenLightModeParamId)

		arg_16_0._tweenLightModeParamId = nil
	end

	WeatherController.instance:unregisterCallback(WeatherEvent.WeatherChanged, arg_16_0._weatherChanged, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._checkReport, arg_16_0)
end

return var_0_0
