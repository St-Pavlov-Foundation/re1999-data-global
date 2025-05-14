module("modules.configs.excel2json.lua_room_building_skin", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
