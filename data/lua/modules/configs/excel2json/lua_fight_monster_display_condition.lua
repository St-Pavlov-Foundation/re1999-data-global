module("modules.configs.excel2json.lua_fight_monster_display_condition", package.seeall)

slot1 = {
	id = 1,
	buffId = 2
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
