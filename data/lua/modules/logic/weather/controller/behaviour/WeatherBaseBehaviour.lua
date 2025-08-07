module("modules.logic.weather.controller.behaviour.WeatherBaseBehaviour", package.seeall)

local var_0_0 = class("WeatherBaseBehaviour", LuaCompBase)

function var_0_0.setSceneConfig(arg_1_0, arg_1_1)
	arg_1_0._sceneConfig = arg_1_1

	arg_1_0:_onSetSceneConfig()
end

function var_0_0._onSetSceneConfig(arg_2_0)
	return
end

function var_0_0.setLightMats(arg_3_0, arg_3_1)
	return
end

function var_0_0.setReport(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._prevReport = arg_4_1
	arg_4_0._curReport = arg_4_2

	arg_4_0:_onReportChange()
end

function var_0_0._onReportChange(arg_5_0)
	return
end

function var_0_0.changeBlendValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return
end

return var_0_0
