module("modules.configs.excel2json.lua_actvity186_mini_game", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	gameType2Prob = 6,
	expireSeconds = 7,
	triggerConditionParams = 4,
	triggerConditionType = 3,
	id = 2,
	activityId = 1,
	conditionStage = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
