module("modules.configs.excel2json.lua_fight_next_round_get_card", package.seeall)

slot1 = {
	exclusion = 5,
	priority = 2,
	tempCard = 6,
	skillId = 4,
	id = 1,
	condition = 3
}
slot2 = {
	"id",
	"priority"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
