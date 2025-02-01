module("modules.configs.excel2json.lua_activity161_graffiti_chess", package.seeall)

slot1 = {
	chessId = 1,
	pos = 3,
	resource = 2
}
slot2 = {
	"chessId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
