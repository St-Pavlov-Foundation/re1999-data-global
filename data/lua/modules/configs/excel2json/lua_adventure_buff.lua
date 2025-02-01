module("modules.configs.excel2json.lua_adventure_buff", package.seeall)

slot1 = {
	type = 6,
	name = 4,
	maxCountInMap = 8,
	skillId = 3,
	id = 1,
	icon = 2,
	rare = 7,
	desc = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
