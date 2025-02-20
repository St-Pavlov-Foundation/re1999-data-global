module("modules.configs.excel2json.lua_room_theme", package.seeall)

slot1 = {
	collectionBonus = 8,
	name = 2,
	desc = 4,
	packages = 7,
	building = 6,
	sourcesType = 10,
	id = 1,
	extraShowBuilding = 9,
	rewardIcon = 5,
	nameEn = 3
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
