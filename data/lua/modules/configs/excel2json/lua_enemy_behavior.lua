module("modules.configs.excel2json.lua_enemy_behavior", package.seeall)

slot1 = {
	effectRound = 3,
	chessId = 4,
	strategy = 6,
	behaviorGroup = 2,
	id = 1,
	effectCondition = 5
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
