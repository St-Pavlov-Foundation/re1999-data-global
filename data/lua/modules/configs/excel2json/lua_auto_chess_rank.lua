module("modules.configs.excel2json.lua_auto_chess_rank", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 8,
	name = 4,
	protection = 5,
	score = 6,
	rankId = 2,
	isShow = 9,
	icon = 3,
	activityId = 1,
	round2Score = 7
}
local var_0_2 = {
	"activityId",
	"rankId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
