module("modules.configs.excel2json.lua_activity174_match", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 4,
	rank = 2,
	count = 3,
	matchRule = 5,
	robotRate = 9,
	matchRuleLimit = 6,
	lostValue = 8,
	activityId = 1,
	winValue = 7
}
local var_0_2 = {
	"activityId",
	"rank",
	"count"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
