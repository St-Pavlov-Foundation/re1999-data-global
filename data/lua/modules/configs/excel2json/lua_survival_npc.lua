module("modules.configs.excel2json.lua_survival_npc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	npcDesc = 11,
	name = 2,
	headIcon = 8,
	rotate = 7,
	transferId = 17,
	choiceText = 10,
	versions = 3,
	desc = 5,
	surBehavior = 19,
	smallIcon = 9,
	subType = 12,
	copyIds = 21,
	tag = 14,
	worldLevel = 20,
	roll = 23,
	incidental = 24,
	cost = 16,
	priority = 22,
	incidentalRange = 25,
	recruitment = 15,
	rare = 13,
	resource = 6,
	behavior = 18,
	seasons = 4,
	id = 1
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
