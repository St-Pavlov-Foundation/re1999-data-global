module("modules.configs.excel2json.lua_auto_chess_enemy_formation", package.seeall)

slot1 = {
	index5 = 9,
	index3 = 7,
	zoneId = 4,
	index1Buff = 10,
	index3Buff = 12,
	index4 = 8,
	round = 3,
	index2Buff = 11,
	index4Buff = 13,
	index2 = 6,
	index5Buff = 14,
	enemyId = 2,
	id = 1,
	index1 = 5
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
