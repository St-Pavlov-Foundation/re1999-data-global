module("modules.configs.excel2json.lua_activity116_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 7,
	name = 2,
	configType = 6,
	desc = 8,
	filterEpisode = 11,
	buildingType = 4,
	elementId = 3,
	lightBgUrl = 10,
	id = 1,
	icon = 9,
	level = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
