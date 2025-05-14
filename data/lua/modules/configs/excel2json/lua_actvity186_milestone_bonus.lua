module("modules.configs.excel2json.lua_actvity186_milestone_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	loopBonusIntervalNum = 5,
	isSpBonus = 7,
	coinNum = 3,
	rewardId = 2,
	bonus = 6,
	activityId = 1,
	isLoopBonus = 4
}
local var_0_2 = {
	"activityId",
	"rewardId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
