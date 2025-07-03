module("modules.configs.excel2json.lua_activity191_stage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 7,
	name = 6,
	rule = 5,
	nextId = 3,
	id = 2,
	initStage = 4,
	activityId = 1,
	coin = 8
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
