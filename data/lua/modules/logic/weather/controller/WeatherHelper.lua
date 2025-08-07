module("modules.logic.weather.controller.WeatherHelper", package.seeall)

local var_0_0 = class("WeatherHelper")

function var_0_0.getResourcePrefix(arg_1_0)
	return string.gsub(arg_1_0, "_colorchange_day", "")
end

function var_0_0.getNightResourcePrefix(arg_2_0)
	return string.gsub(arg_2_0, "_colorchange_night", "")
end

function var_0_0.skipLightMap(arg_3_0, arg_3_1)
	if arg_3_0 == MainSceneSwitchEnum.SpSceneId and string.find(arg_3_1, "_colorchange_night") then
		return true
	end

	return false
end

return var_0_0
