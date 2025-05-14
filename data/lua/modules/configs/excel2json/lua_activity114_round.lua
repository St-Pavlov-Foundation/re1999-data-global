module("modules.configs.excel2json.lua_activity114_round", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 5,
	storyId = 10,
	isSkip = 12,
	type = 4,
	eventId = 8,
	transition = 11,
	day = 2,
	banButton2 = 7,
	banButton1 = 6,
	id = 3,
	activityId = 1,
	preStoryId = 9
}
local var_0_2 = {
	"activityId",
	"day",
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
