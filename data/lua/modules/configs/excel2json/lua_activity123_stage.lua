module("modules.configs.excel2json.lua_activity123_stage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	recommendSchool = 12,
	name = 4,
	preCondition = 3,
	finalScale = 9,
	initPos = 6,
	initScale = 7,
	stageCondition = 11,
	res = 5,
	finalPos = 8,
	stage = 2,
	activityId = 1,
	recommend = 10
}
local var_0_2 = {
	"activityId",
	"stage"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
