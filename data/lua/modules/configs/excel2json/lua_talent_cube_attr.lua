module("modules.configs.excel2json.lua_talent_cube_attr", package.seeall)

slot1 = {
	cri = 9,
	calculateType = 4,
	cri_def = 12,
	defenseIgnore = 19,
	cri_dmg = 11,
	clutch = 17,
	mdef = 8,
	heal = 18,
	add_dmg = 13,
	def = 7,
	normalSkillRate = 20,
	atk = 6,
	icon = 3,
	level = 2,
	absorb = 16,
	revive = 15,
	recri = 10,
	drop_dmg = 14,
	hp = 5,
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
