module("modules.configs.excel2json.lua_rouge_difficulty", package.seeall)

slot1 = {
	title_en = 5,
	preDifficulty = 6,
	scoreReward = 8,
	startView = 9,
	season = 1,
	title = 4,
	initEffects = 11,
	desc = 12,
	monsterDesc = 7,
	balanceLevel = 13,
	initCollections = 10,
	version = 3,
	difficulty = 2
}
slot2 = {
	"season",
	"difficulty"
}
slot3 = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
