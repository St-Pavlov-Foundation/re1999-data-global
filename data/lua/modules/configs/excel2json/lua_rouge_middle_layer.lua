module("modules.configs.excel2json.lua_rouge_middle_layer", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	leavePosUnlockType = 10,
	name = 3,
	leavePosUnlockParam = 11,
	dayOrNight = 13,
	pointPos = 7,
	empty = 14,
	path = 12,
	pathPointPos = 8,
	pathSelect = 5,
	leavePos = 9,
	id = 1,
	version = 2,
	nextLayer = 4,
	mapRes = 6
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
