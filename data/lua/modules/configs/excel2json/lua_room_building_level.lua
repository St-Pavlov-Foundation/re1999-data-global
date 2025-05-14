module("modules.configs.excel2json.lua_room_building_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
local var_0_2 = {
	"id",
	"level"
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
