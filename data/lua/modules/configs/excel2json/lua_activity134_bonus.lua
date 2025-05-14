module("modules.configs.excel2json.lua_activity134_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	showTab = 5,
	introduce = 8,
	desc = 7,
	id = 2,
	bonus = 10,
	title = 6,
	number = 3,
	needTokens = 11,
	storyType = 4,
	activityId = 1,
	due = 9
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 3,
	introduce = 4,
	due = 5,
	title = 2,
	number = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
