module("modules.configs.excel2json.lua_manufacture_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 3,
	needMat = 2,
	criProductionCount = 5,
	batchName = 6,
	showInAdvancedOrder = 10,
	orderPrice = 11,
	unitCount = 9,
	batchIcon = 7,
	needTime = 8,
	id = 1,
	criProductionId = 4,
	wholesalePrice = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	batchName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
