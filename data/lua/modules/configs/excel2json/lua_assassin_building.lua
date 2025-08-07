module("modules.configs.excel2json.lua_assassin_building", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 7,
	buildingBgIcon = 10,
	unlockDesc = 5,
	type = 3,
	effectDesc = 6,
	title = 2,
	lockBuildingIcon = 9,
	desc = 13,
	levelupPic = 12,
	itemIcon = 11,
	id = 1,
	buildingIcon = 8,
	level = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	effectDesc = 3,
	title = 1,
	unlockDesc = 2,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
