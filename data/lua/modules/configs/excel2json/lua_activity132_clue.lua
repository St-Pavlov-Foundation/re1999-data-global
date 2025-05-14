module("modules.configs.excel2json.lua_activity132_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	contents = 4,
	name = 3,
	pos = 5,
	clueId = 2,
	smallBg = 6,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"clueId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
