module("modules.configs.excel2json.lua_activity174_enhance", package.seeall)

slot1 = {
	effects = 7,
	icon = 6,
	season = 2,
	coinValue = 8,
	id = 1,
	title = 4,
	rare = 3,
	desc = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
