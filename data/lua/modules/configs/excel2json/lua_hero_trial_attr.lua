module("modules.configs.excel2json.lua_hero_trial_attr", package.seeall)

slot1 = {
	defense = 9,
	name = 2,
	technic = 11,
	dropDmg = 17,
	uniqueSkill = 5,
	activeSkill = 3,
	addDmg = 16,
	criDmg = 14,
	attack = 8,
	criDef = 15,
	passiveSkill = 4,
	cri = 12,
	mdefense = 10,
	recri = 13,
	noShowExSkill = 6,
	life = 7,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
