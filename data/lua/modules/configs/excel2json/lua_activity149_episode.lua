module("modules.configs.excel2json.lua_activity149_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	order = 4,
	multi = 5,
	firstPassScore = 6,
	id = 1,
	effectCondition = 7,
	activityId = 2,
	episodeId = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
