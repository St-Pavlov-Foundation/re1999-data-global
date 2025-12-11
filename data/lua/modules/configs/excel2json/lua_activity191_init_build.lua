module("modules.configs.excel2json.lua_activity191_init_build", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 3,
	randHero = 8,
	item = 7,
	rewardHero = 10,
	randItem = 9,
	hero = 6,
	rewardItem = 11,
	desc = 4,
	style = 2,
	coin = 5,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"style"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
