module("modules.configs.excel2json.lua_fight_die_act_enemyus", package.seeall)

slot1 = {
	id = 1,
	act = 3,
	playEffect = 4,
	enemyus = 2
}
slot2 = {
	"id",
	"enemyus"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
