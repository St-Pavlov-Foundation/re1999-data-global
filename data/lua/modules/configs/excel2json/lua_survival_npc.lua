module("modules.configs.excel2json.lua_survival_npc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	npcDesc = 14,
	name = 2,
	waterResource = 9,
	rotate = 10,
	transferId = 20,
	choiceText = 13,
	recruitment = 18,
	desc = 7,
	surBehavior = 22,
	subType = 15,
	smallIcon = 12,
	copyIds = 24,
	tag = 17,
	worldLevel = 23,
	cost = 19,
	priority = 25,
	versions = 5,
	extendCost = 3,
	roll = 26,
	incidentalRange = 28,
	incidental = 27,
	headIcon = 11,
	rare = 16,
	resource = 8,
	renown = 29,
	behavior = 21,
	seasons = 6,
	id = 1,
	takeOut = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	npcDesc = 4,
	name = 1,
	choiceText = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
