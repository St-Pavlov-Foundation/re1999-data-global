module("modules.configs.excel2json.lua_eliminate_slot", package.seeall)

slot1 = {
	defaultUnlock = 2,
	chessId = 1
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
