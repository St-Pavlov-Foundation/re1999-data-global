module("modules.configs.excel2json.lua_survival_mission", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 6,
	name = 2,
	worldLevel = 17,
	rotate = 11,
	grid = 10,
	choiceText = 13,
	isRepeat = 18,
	camera = 12,
	incidental = 20,
	subType = 15,
	copyIds = 16,
	versions = 4,
	priority = 7,
	incidentalRange = 21,
	group = 3,
	roll = 19,
	resource = 8,
	enforce = 14,
	seasons = 5,
	id = 1,
	waterResource = 9
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
