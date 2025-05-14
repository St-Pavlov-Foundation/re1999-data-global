module("modules.configs.excel2json.lua_resistances_attribute", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	forbid = 7,
	sleep = 3,
	dizzy = 2,
	frozen = 5,
	petrified = 4,
	delExPointResilience = 14,
	delExPoint = 11,
	stressUp = 12,
	controlResilience = 13,
	charm = 10,
	stressUpResilience = 15,
	seal = 8,
	id = 1,
	disarm = 6,
	cantGetExskill = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
