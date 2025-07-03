module("modules.configs.excel2json.lua_activity191_fight_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightLevel = 11,
	skinId = 5,
	bloodAward = 9,
	type = 2,
	autoRewardView = 8,
	title = 3,
	offset = 6,
	episodeId = 4,
	rewardView = 7,
	autoAward = 10,
	id = 1
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
