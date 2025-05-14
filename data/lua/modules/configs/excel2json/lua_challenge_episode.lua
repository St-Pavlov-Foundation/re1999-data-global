module("modules.configs.excel2json.lua_challenge_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	hiddenRule2 = 11,
	ruleIcon = 13,
	ruleDesc1 = 9,
	type = 3,
	groupId = 4,
	title = 15,
	preEpisodeIds = 5,
	desc = 16,
	episodeId = 1,
	reportIcon = 18,
	icon = 17,
	activityId = 2,
	order = 6,
	hiddenRule1 = 8,
	resultIcon = 19,
	rule1 = 7,
	condition = 14,
	ruleDesc2 = 12,
	rule2 = 10
}
local var_0_2 = {
	"episodeId"
}
local var_0_3 = {
	title = 3,
	ruleDesc2 = 2,
	ruleDesc1 = 1,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
