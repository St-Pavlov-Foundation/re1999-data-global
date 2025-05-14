module("modules.configs.excel2json.lua_room_theme", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	collectionBonus = 8,
	name = 2,
	desc = 4,
	packages = 7,
	building = 6,
	sourcesType = 10,
	id = 1,
	extraShowBuilding = 9,
	rewardIcon = 5,
	nameEn = 3
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
