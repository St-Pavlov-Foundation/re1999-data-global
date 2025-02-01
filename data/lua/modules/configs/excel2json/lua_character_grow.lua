module("modules.configs.excel2json.lua_character_grow", package.seeall)

slot1 = {
	technic = 7,
	def = 5,
	hp = 3,
	atk = 4,
	id = 1,
	icon = 2,
	mdef = 6
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
