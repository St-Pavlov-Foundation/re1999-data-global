module("modules.configs.excel2json.lua_odyssey_element", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type = 4,
	iconFrame = 7,
	refreshType = 11,
	main = 8,
	needFollow = 10,
	unlockCondition = 3,
	pos = 5,
	taskDesc = 9,
	isPermanent = 12,
	mapId = 2,
	heroPos = 13,
	dataBase = 14,
	id = 1,
	icon = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	taskDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
