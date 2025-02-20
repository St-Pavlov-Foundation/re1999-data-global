module("modules.configs.excel2json.lua_activity174_template", package.seeall)

slot1 = {
	defense = 4,
	id = 1,
	technic = 6,
	life = 2,
	attack = 3,
	mdefense = 5
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
