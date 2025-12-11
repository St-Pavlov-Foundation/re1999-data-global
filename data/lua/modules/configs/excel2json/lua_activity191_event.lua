module("modules.configs.excel2json.lua_activity191_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skinId = 10,
	outDesc = 6,
	type = 3,
	title = 5,
	offset = 11,
	desc = 7,
	rewardView = 9,
	task = 8,
	id = 1,
	stage = 4,
	activityId = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	outDesc = 2,
	title = 1,
	task = 4,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
