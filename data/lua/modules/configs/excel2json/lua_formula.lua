module("modules.configs.excel2json.lua_formula", package.seeall)

slot1 = {
	showType = 3,
	needEpisodeId = 13,
	needRoomLevel = 11,
	type = 2,
	needProductionLevel = 12,
	name = 4,
	produce = 8,
	desc = 17,
	costMaterial = 5,
	icon = 14,
	costReserve = 9,
	order = 10,
	costTime = 7,
	useDesc = 16,
	rare = 15,
	costScore = 6,
	id = 1
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
