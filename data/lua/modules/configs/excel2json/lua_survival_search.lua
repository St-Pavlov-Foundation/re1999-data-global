module("modules.configs.excel2json.lua_survival_search", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	drop = 15,
	name = 2,
	desc = 6,
	rotate = 11,
	grid = 10,
	choiceText = 13,
	copyIds = 18,
	camera = 12,
	worldLevel = 19,
	subType = 17,
	isRepeat = 20,
	consume = 14,
	incidental = 22,
	versions = 4,
	priority = 7,
	incidentalRange = 23,
	group = 3,
	roll = 21,
	resource = 8,
	enforce = 16,
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
