module("modules.configs.excel2json.lua_activity104_equip_attr", package.seeall)

slot1 = {
	dropDmg = 11,
	def = 4,
	cri = 6,
	defenseIgnore = 14,
	atk = 3,
	normalSkillRate = 17,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	criDef = 9,
	clutch = 16,
	attrId = 1,
	absorb = 15,
	revive = 13,
	recri = 7,
	hp = 2,
	heal = 12
}
slot2 = {
	"attrId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
