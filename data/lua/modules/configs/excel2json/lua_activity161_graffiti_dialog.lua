module("modules.configs.excel2json.lua_activity161_graffiti_dialog", package.seeall)

slot1 = {
	stepId = 2,
	dialogId = 1,
	chessId = 3,
	dialog = 4
}
slot2 = {
	"dialogId",
	"stepId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
