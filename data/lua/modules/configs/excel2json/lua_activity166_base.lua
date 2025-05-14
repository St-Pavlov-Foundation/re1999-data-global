module("modules.configs.excel2json.lua_activity166_base", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	talentId = 4,
	name = 5,
	desc = 6,
	level = 7,
	baseId = 2,
	strategy = 8,
	activityId = 1,
	episodeId = 3
}
local var_0_2 = {
	"activityId",
	"baseId"
}
local var_0_3 = {
	strategy = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
