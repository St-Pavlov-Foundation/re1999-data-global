module("modules.configs.excel2json.lua_room_building_skin", package.seeall)

slot1 = {
	itemId = 3,
	name = 4,
	useDesc = 5,
	path = 11,
	vehicleId = 12,
	rare = 9,
	desc = 6,
	buildingId = 2,
	id = 1,
	icon = 7,
	rewardIcon = 8,
	nameEn = 10
}
slot2 = {
	"id"
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
