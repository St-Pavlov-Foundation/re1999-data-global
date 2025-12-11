module("modules.configs.excel2json.lua_activity191_fight_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightLevel = 12,
	autoRewardView = 9,
	bloodAward = 10,
	type = 3,
	skinId = 6,
	title = 4,
	offset = 7,
	episodeId = 5,
	rewardView = 8,
	autoAward = 11,
	id = 1,
	activityId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
