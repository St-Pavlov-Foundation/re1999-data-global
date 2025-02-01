module("modules.configs.excel2json.lua_stress_origin", package.seeall)

slot1 = {
	id = 1,
	effect = 3,
	param = 4,
	type = 2
}
slot2 = {
	"id",
	"type"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
