module("modules.configs.excel2json.lua_critter_hero_preference", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	preferenceValue = 3,
	attachEventId = 8,
	attachAttribute = 10,
	preferenceType = 2,
	attachStoryId = 11,
	addIncrRate = 6,
	desc = 7,
	attachOption = 9,
	heroId = 1,
	spEventId = 12,
	critterIcon = 4,
	effectAttribute = 5
}
local var_0_2 = {
	"heroId"
}
local var_0_3 = {
	attachOption = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
