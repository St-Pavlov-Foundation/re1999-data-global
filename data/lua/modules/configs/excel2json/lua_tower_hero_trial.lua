module("modules.configs.excel2json.lua_tower_hero_trial", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	season = 1,
	endTime = 3,
	heroIds = 4,
	startTime = 2
}
local var_0_2 = {
	"season"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
