module("modules.configs.excel2json.lua_activity133_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	finalBonus = 9,
	title = 3,
	pos = 8,
	desc = 4,
	needTokens = 7,
	id = 2,
	icon = 5,
	activityId = 1,
	bonus = 6
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
