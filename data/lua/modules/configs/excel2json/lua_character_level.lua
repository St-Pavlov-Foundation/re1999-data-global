module("modules.configs.excel2json.lua_character_level", package.seeall)

slot1 = {
	cri_def = 11,
	def = 5,
	technic = 7,
	cri = 8,
	cri_dmg = 10,
	recri = 9,
	mdef = 6,
	drop_dmg = 13,
	add_dmg = 12,
	heroId = 1,
	hp = 3,
	atk = 4,
	level = 2
}
slot2 = {
	"heroId",
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
