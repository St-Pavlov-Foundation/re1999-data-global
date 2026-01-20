-- chunkname: @modules/configs/excel2json/lua_survival_npc.lua

module("modules.configs.excel2json.lua_survival_npc", package.seeall)

local lua_survival_npc = {}
local fields = {
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
local primaryKey = {
	"id"
}
local mlStringKey = {
	npcDesc = 4,
	name = 1,
	choiceText = 3,
	desc = 2
}

function lua_survival_npc.onLoad(json)
	lua_survival_npc.configList, lua_survival_npc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_npc
