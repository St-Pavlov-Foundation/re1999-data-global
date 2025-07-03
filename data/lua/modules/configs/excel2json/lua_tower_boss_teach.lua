module("modules.configs.excel2json.lua_tower_boss_teach", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	episodeId = 3,
	name = 6,
	desc = 7,
	teachId = 2,
	firstBonus = 4,
	planId = 5,
	towerId = 1
}
local var_0_2 = {
	"towerId",
	"teachId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
