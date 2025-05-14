module("modules.configs.excel2json.lua_activity129_pool", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 6,
	name = 4,
	nameEn = 5,
	type = 3,
	maxDraw = 7,
	activityId = 1,
	poolId = 2
}
local var_0_2 = {
	"activityId",
	"poolId"
}
local var_0_3 = {
	nameEn = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
