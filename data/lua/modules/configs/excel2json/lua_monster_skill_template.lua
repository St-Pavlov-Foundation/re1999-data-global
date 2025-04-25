module("modules.configs.excel2json.lua_monster_skill_template", package.seeall)

slot1 = {
	gender = 7,
	name = 2,
	career = 8,
	baseStress = 18,
	uniqueSkill = 12,
	uniqueSkill_point = 13,
	nameEng = 3,
	identity = 20,
	race = 21,
	camp = 17,
	dmgType = 9,
	activeSkill = 11,
	powerMax = 15,
	des = 4,
	passiveSkill = 10,
	instance = 6,
	property = 16,
	resistance = 14,
	template = 5,
	id = 1,
	maxStress = 19
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
