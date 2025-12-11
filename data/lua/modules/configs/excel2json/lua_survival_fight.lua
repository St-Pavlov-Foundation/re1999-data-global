module("modules.configs.excel2json.lua_survival_fight", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightLevel = 20,
	name = 2,
	choiceText = 14,
	rotate = 11,
	grid = 10,
	warningRange = 15,
	skip = 17,
	camera = 12,
	transferId = 18,
	subType = 21,
	desc = 6,
	copyIds = 22,
	battleId = 19,
	worldLevel = 23,
	isRepeat = 24,
	incidental = 26,
	versions = 4,
	priority = 7,
	incidentalRange = 27,
	group = 3,
	roll = 25,
	resource = 8,
	enforce = 16,
	behavior = 13,
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
