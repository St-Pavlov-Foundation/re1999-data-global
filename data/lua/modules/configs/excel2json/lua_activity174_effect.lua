module("modules.configs.excel2json.lua_activity174_effect", package.seeall)

slot1 = {
	season = 2,
	id = 1,
	typeParam = 4,
	type = 3
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
