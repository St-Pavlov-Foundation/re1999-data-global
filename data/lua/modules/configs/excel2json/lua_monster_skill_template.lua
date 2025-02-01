module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

slot1 = {
	gender = 6,
	name = 2,
	career = 7,
	baseStress = 17,
	uniqueSkill = 11,
	uniqueSkill_point = 12,
	nameEng = 3,
	identity = 19,
	race = 20,
	camp = 16,
	dmgType = 8,
	activeSkill = 10,
	powerMax = 14,
	des = 4,
	passiveSkill = 9,
	property = 15,
	resistance = 13,
	template = 5,
	id = 1,
	maxStress = 18
}
slot2 = {
	"id"
}
slot3 = {
	property = 3,
	name = 1,
	des = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
