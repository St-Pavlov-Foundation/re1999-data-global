module("modules.configs.excel2json.lua_monster_level", package.seeall)

slot1 = {
	equip_base = 5,
	equip_super = 6,
	technic = 3,
	base = 2,
	id = 1,
	base_super = 4
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
