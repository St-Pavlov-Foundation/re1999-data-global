module("modules.configs.excel2json.lua_survival_fight", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightLevel = 18,
	name = 2,
	choiceText = 12,
	rotate = 9,
	transferId = 16,
	warningRange = 13,
	grid = 8,
	desc = 5,
	camera = 10,
	subType = 19,
	skip = 15,
	copyIds = 20,
	battleId = 17,
	worldLevel = 21,
	isRepeat = 22,
	incidental = 24,
	versions = 3,
	priority = 6,
	incidentalRange = 25,
	roll = 23,
	resource = 7,
	enforce = 14,
	behavior = 11,
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
