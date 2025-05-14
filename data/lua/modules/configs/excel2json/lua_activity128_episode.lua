module("modules.configs.excel2json.lua_activity128_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 9,
	enhanceRole = 5,
	recommendLevelDesc = 8,
	type = 4,
	episodeId = 6,
	evaluate = 10,
	desc = 7,
	stage = 2,
	activityId = 1,
	layer = 3
}
local var_0_2 = {
	"activityId",
	"stage",
	"layer"
}
local var_0_3 = {
	recommendLevelDesc = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
