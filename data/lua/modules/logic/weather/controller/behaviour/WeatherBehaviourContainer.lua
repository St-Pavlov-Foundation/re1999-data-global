module("modules.logic.weather.controller.behaviour.WeatherBehaviourContainer", package.seeall)

local var_0_0 = class("WeatherBehaviourContainer", BaseUnitSpawn)

function var_0_0.Create(arg_1_0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)
end

function var_0_0.setSceneId(arg_2_0, arg_2_1)
	arg_2_0._sceneId = arg_2_1
	arg_2_0._sceneConfig = lua_scene_switch.configDict[arg_2_0._sceneId]

	if arg_2_0._sceneId == MainSceneSwitchEnum.SpSceneId then
		arg_2_0:addComp("dayNightChange", WeatherDayNightChange)
		arg_2_0.dayNightChange:setSceneConfig(arg_2_0._sceneConfig)
	end
end

function var_0_0.setLightMats(arg_3_0, arg_3_1)
	if arg_3_0._sceneId == MainSceneSwitchEnum.SpSceneId then
		arg_3_0.dayNightChange:setLightMats(arg_3_1)
	end
end

function var_0_0.initComponents(arg_4_0)
	return
end

function var_0_0.setReport(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._prevReport = arg_5_1
	arg_5_0._curReport = arg_5_2

	local var_5_0 = arg_5_0:getCompList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		iter_5_1:setReport(arg_5_1, arg_5_2)
	end
end

function var_0_0.changeBlendValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.dayNightChange then
		arg_6_0.dayNightChange:changeBlendValue(arg_6_1, arg_6_2, arg_6_3)
	end
end

return var_0_0
