module("modules.configs.excel2json.lua_boss_action", package.seeall)

slot1 = {
	battleId = 1,
	monsterId = 2,
	monsterSpeed = 3,
	actionId = 4
}
slot2 = {
	"battleId",
	"monsterId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
