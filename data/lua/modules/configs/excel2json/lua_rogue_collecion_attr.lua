module("modules.configs.excel2json.lua_rogue_collecion_attr", package.seeall)

slot1 = {
	revive = 13,
	def = 4,
	dropDmg = 11,
	defenseIgnore = 14,
	cri = 6,
	id = 1,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	attack = 3,
	criDef = 9,
	clutch = 17,
	absorb = 15,
	normalSkillRate = 16,
	recri = 7,
	hp = 2,
	heal = 12
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
