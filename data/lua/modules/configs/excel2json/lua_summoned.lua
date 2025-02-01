module("modules.configs.excel2json.lua_summoned", package.seeall)

slot1 = {
	group = 4,
	enterTime = 14,
	includeTypes = 5,
	closeTime = 15,
	enterAudio = 16,
	aniEffect = 10,
	maxLevel = 3,
	skills = 6,
	uniqueSkills = 7,
	closeAudio = 17,
	level = 2,
	stanceId = 9,
	closeEffect = 13,
	enterEffect = 11,
	additionRule = 8,
	loopEffect = 12,
	id = 1
}
slot2 = {
	"id",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
