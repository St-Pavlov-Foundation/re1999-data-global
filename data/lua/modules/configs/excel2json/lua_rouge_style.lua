module("modules.configs.excel2json.lua_rouge_style", package.seeall)

slot1 = {
	coin = 8,
	name = 4,
	talentPointGroup = 17,
	layoutId = 11,
	season = 1,
	mapSkills = 15,
	passiveSkillDescs = 12,
	desc = 5,
	unlockType = 18,
	capacity = 7,
	talentSkill = 16,
	power = 9,
	icon = 6,
	unlockParam = 19,
	halfCost = 20,
	activeSkills = 14,
	passiveSkillDescs2 = 13,
	id = 2,
	version = 3,
	powerLimit = 10
}
slot2 = {
	"season",
	"id"
}
slot3 = {
	passiveSkillDescs2 = 4,
	name = 1,
	passiveSkillDescs = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
