module("modules.configs.excel2json.lua_activity116_building", package.seeall)

slot1 = {
	cost = 7,
	name = 2,
	configType = 6,
	desc = 8,
	filterEpisode = 11,
	buildingType = 4,
	elementId = 3,
	lightBgUrl = 10,
	id = 1,
	icon = 9,
	level = 5
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
