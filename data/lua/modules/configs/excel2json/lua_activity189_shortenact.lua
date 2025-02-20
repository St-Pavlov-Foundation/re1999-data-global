module("modules.configs.excel2json.lua_activity189_shortenact", package.seeall)

slot1 = {
	id = 1,
	version = 2,
	style = 4,
	settingId = 3
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
