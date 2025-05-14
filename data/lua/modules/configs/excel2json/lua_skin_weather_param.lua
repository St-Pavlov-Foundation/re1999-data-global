module("modules.configs.excel2json.lua_skin_weather_param", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	emissionColor3 = 12,
	bloomColor3 = 4,
	mainColor1 = 6,
	mainColor2 = 7,
	emissionColor1 = 10,
	bloomColor1 = 2,
	emissionColor4 = 13,
	bloomColor4 = 5,
	mainColor3 = 8,
	emissionColor2 = 11,
	bloomColor2 = 3,
	id = 1,
	mainColor4 = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
