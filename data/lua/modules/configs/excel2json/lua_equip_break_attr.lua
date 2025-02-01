module("modules.configs.excel2json.lua_equip_break_attr", package.seeall)

slot1 = {
	dropDmg = 12,
	def = 5,
	cri = 7,
	defenseIgnore = 15,
	id = 1,
	normalSkillRate = 17,
	mdef = 6,
	addDmg = 11,
	criDmg = 9,
	attack = 3,
	criDef = 10,
	clutch = 18,
	absorb = 16,
	revive = 14,
	recri = 8,
	hp = 4,
	breakLevel = 2,
	heal = 13
}
slot2 = {
	"id",
	"breakLevel"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
