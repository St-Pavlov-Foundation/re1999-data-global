module("modules.configs.excel2json.lua_activity121_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyTag = 5,
	name = 3,
	clueId = 1,
	tagType = 4,
	activityId = 2
}
local var_0_2 = {
	"clueId",
	"activityId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
