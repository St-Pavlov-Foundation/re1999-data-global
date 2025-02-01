module("modules.configs.excel2json.lua_activity108_rule", package.seeall)

slot1 = {
	rules = 2,
	id = 1,
	threat = 3
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
