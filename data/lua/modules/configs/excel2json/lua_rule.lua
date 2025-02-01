module("modules.configs.excel2json.lua_rule", package.seeall)

slot1 = {
	effect = 7,
	name = 5,
	type = 2,
	id = 1,
	icon = 3,
	iconTag = 4,
	desc = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
