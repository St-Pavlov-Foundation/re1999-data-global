module("modules.configs.excel2json.lua_fight_tower_500m_boss_behaviour", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	monsterid = 2,
	param2 = 4,
	hpColor = 13,
	param1 = 3,
	hpBgColor = 12,
	param3 = 5,
	param9 = 11,
	param7 = 9,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param4 = 6,
	level = 1
}
local var_0_2 = {
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
