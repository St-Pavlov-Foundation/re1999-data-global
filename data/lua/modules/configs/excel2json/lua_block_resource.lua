module("modules.configs.excel2json.lua_block_resource", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
