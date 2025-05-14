module("modules.configs.excel2json.lua_actvity186_mini_game_question", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	rewardId1 = 7,
	rewardId2 = 10,
	question = 4,
	answer3 = 11,
	rewardId3 = 13,
	feedback3 = 12,
	hanzhangline4 = 14,
	answer2 = 8,
	feedback1 = 6,
	answer1 = 5,
	feedback2 = 9,
	id = 2,
	activityId = 1,
	sort = 3
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	answer2 = 4,
	feedback1 = 3,
	question = 1,
	feedback2 = 5,
	hanzhangline4 = 8,
	feedback3 = 7,
	answer3 = 6,
	answer1 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
