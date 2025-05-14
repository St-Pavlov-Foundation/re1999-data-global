module("modules.configs.excel2json.lua_activity114_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	checkOptionText = 6,
	isCheckEvent = 12,
	disposable = 11,
	successVerify = 13,
	battleId = 19,
	testId = 20,
	eventType = 4,
	successBattle = 17,
	activityId = 1,
	isTransition = 21,
	param = 5,
	storyId = 3,
	threshold = 10,
	checkAttribute = 8,
	condition = 18,
	nonOptionText = 7,
	failureStoryId = 16,
	id = 2,
	failureVerify = 15,
	successStoryId = 14,
	checkfeatures = 9
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	checkOptionText = 1,
	nonOptionText = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
