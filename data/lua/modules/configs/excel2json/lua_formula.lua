module("modules.configs.excel2json.lua_formula", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
