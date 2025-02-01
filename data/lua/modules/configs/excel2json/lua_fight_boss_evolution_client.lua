module("modules.configs.excel2json.lua_fight_boss_evolution_client", package.seeall)

slot1 = {
	nextSkinId = 2,
	id = 1,
	timeline = 3
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
