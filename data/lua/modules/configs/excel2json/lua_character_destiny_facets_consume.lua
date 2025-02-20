module("modules.configs.excel2json.lua_character_destiny_facets_consume", package.seeall)

slot1 = {
	tend = 4,
	name = 2,
	consume = 3,
	facetsId = 1,
	icon = 5
}
slot2 = {
	"facetsId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
