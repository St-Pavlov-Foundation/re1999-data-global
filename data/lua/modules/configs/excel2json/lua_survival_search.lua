module("modules.configs.excel2json.lua_survival_search", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	consume = 12,
	name = 2,
	camera = 10,
	rotate = 9,
	grid = 8,
	choiceText = 11,
	drop = 13,
	desc = 5,
	worldLevel = 17,
	subType = 15,
	isRepeat = 18,
	copyIds = 16,
	incidental = 20,
	versions = 3,
	priority = 6,
	incidentalRange = 21,
	roll = 19,
	resource = 7,
	enforce = 14,
	seasons = 4,
	id = 1
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
