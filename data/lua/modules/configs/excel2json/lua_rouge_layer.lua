module("modules.configs.excel2json.lua_rouge_layer", package.seeall)

slot1 = {
	version = 2,
	name = 3,
	ruleIdVersion = 5,
	unlockType = 10,
	levelId = 22,
	pathPos = 17,
	iconPos = 18,
	desc = 13,
	bgm = 20,
	crossDesc = 14,
	sceneId = 21,
	ruleIdInstead = 6,
	startStoryId = 8,
	endStoryId = 9,
	mapRes = 7,
	middleLayerId = 4,
	unlockParam = 11,
	iconRes = 15,
	dayOrNight = 19,
	id = 1,
	pathRes = 16,
	nameEn = 12
}
slot2 = {
	"id"
}
slot3 = {
	crossDesc = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
