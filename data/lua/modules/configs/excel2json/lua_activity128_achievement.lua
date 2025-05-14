module("modules.configs.excel2json.lua_activity128_achievement", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	achievementRes = 7,
	rewardPointNum = 6,
	desc = 5,
	minTypeId = 4,
	reward = 8,
	stage = 2,
	activityId = 1,
	taskId = 3
}
local var_0_2 = {
	"activityId",
	"stage",
	"taskId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
