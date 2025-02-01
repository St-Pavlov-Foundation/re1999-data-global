module("modules.configs.excel2json.lua_stress", package.seeall)

slot1 = {
	desc = 3,
	pressParam = 7,
	rule = 8,
	type = 6,
	id = 1,
	title = 4,
	condition = 5,
	identity = 2
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
