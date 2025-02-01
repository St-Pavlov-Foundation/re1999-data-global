module("modules.configs.excel2json.lua_bgm_easteregg", package.seeall)

slot1 = {
	param1 = 3,
	param2 = 4,
	type = 2,
	id = 1,
	param4 = 6,
	param3 = 5
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
