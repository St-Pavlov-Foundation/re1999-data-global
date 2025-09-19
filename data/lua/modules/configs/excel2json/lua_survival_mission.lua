module("modules.configs.excel2json.lua_survival_mission", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	name = 2,
	camera = 10,
	rotate = 9,
	grid = 8,
	choiceText = 11,
	desc = 5,
	isRepeat = 16,
	incidental = 18,
	subType = 13,
	copyIds = 14,
	versions = 3,
	priority = 6,
	incidentalRange = 19,
	roll = 17,
	resource = 7,
	enforce = 12,
	seasons = 4,
	worldLevel = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	choiceText = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
