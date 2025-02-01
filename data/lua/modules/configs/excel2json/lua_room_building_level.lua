module("modules.configs.excel2json.lua_room_building_level", package.seeall)

slot1 = {
	nameEn = 10,
	name = 3,
	useDesc = 4,
	path = 11,
	levelUpIcon = 7,
	rare = 9,
	desc = 5,
	id = 1,
	icon = 6,
	rewardIcon = 8,
	level = 2
}
slot2 = {
	"id",
	"level"
}
slot3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
