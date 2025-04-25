module("modules.configs.excel2json.lua_monster_sub", package.seeall)

slot1 = {
	score = 3,
	life = 4,
	technic = 8,
	job = 2,
	id = 1,
	defense = 6,
	mdefense = 7,
	attack = 5
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
