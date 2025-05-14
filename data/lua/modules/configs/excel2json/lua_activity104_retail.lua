module("modules.configs.excel2json.lua_activity104_retail", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	retailEpisodeIdPool = 3,
	equipRareWeight = 6,
	activityId = 1,
	stage = 2,
	enemyTag = 4,
	level = 5
}
local var_0_2 = {
	"activityId",
	"stage"
}
local var_0_3 = {
	enemyTag = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
