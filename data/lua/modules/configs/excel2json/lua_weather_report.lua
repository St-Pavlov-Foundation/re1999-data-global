module("modules.configs.excel2json.lua_weather_report", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioLength = 6,
	effect = 4,
	roomMode = 5,
	id = 1,
	lightMode = 2,
	roleMode = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
