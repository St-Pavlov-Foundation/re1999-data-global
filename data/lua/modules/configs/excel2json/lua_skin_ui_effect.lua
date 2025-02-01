module("modules.configs.excel2json.lua_skin_ui_effect", package.seeall)

slot1 = {
	delayVisible = 5,
	effect = 2,
	id = 1,
	changeVisible = 4,
	realtime = 7,
	scale = 3,
	frameVisible = 6
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
