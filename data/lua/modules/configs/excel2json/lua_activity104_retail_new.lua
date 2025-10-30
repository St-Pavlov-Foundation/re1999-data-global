module("modules.configs.excel2json.lua_activity104_retail_new", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	level = 4,
	equipRareWeight = 5,
	retailEpisodeId = 2,
	activityId = 1,
	desc = 3
}
local var_0_2 = {
	"activityId",
	"retailEpisodeId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
