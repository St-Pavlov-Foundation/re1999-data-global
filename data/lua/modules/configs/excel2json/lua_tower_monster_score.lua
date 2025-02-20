module("modules.configs.excel2json.lua_tower_monster_score", package.seeall)

slot1 = {
	killScore = 3,
	monsterId = 1,
	hpPerScore = 2
}
slot2 = {
	"monsterId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
