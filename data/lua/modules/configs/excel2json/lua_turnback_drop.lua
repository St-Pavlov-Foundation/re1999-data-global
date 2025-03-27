module("modules.configs.excel2json.lua_turnback_drop", package.seeall)

slot1 = {
	listenerParam = 5,
	name = 3,
	jumpId = 6,
	type = 4,
	id = 1,
	picPath = 7,
	level = 2
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
