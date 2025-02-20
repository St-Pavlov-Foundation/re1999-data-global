module("modules.configs.excel2json.lua_character_destiny_facets", package.seeall)

slot1 = {
	level = 2,
	exchangeSkills = 3,
	desc = 4,
	facetsId = 1
}
slot2 = {
	"facetsId",
	"level"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
