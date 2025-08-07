module("modules.configs.excel2json.lua_activity206_reward_direction", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 9,
	guaranteeCount = 6,
	pic = 10,
	nextDayDecRate = 4,
	haveGuarantee = 5,
	rewardGroupId = 7,
	baseRate = 3,
	directionId = 2,
	des = 8
}
local var_0_2 = {
	"activityId",
	"directionId"
}
local var_0_3 = {
	name = 2,
	des = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
