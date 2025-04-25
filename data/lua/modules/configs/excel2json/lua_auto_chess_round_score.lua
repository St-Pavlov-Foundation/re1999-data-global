module("modules.configs.excel2json.lua_auto_chess_round_score", package.seeall)

slot1 = {
	score = 2,
	rankId = 1,
	mult = 3
}
slot2 = {
	"rankId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
