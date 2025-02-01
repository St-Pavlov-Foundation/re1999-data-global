module("modules.configs.excel2json.lua_strong_hold_rule", package.seeall)

slot1 = {
	skillIds = 6,
	id = 1,
	fixValue = 4,
	desc = 2,
	prohibitSkillTags = 5,
	fixType = 3,
	addSkillIds = 7,
	effectIds = 8,
	putLimit = 9,
	startEffectRound = 10,
	endEffectRound = 11
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
