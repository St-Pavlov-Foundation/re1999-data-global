module("modules.configs.excel2json.lua_block_resource", package.seeall)

slot1 = {
	itemId = 4,
	name = 2,
	occupied = 6,
	vehicleId = 10,
	path = 3,
	placeBuilding = 9,
	numLimit = 8,
	buildingFilter = 5,
	id = 1,
	blockLight = 7
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
