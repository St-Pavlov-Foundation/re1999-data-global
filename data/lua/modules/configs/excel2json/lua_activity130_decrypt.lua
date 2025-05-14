module("modules.configs.excel2json.lua_activity130_decrypt", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	puzzleType = 6,
	operGroupId = 4,
	puzzleMapId = 3,
	maxStep = 9,
	extStarDesc = 13,
	errorTip = 10,
	maxOper = 8,
	extStarCondition = 12,
	puzzleTip = 11,
	answer = 7,
	puzzleTxt = 5,
	activityId = 1,
	puzzleId = 2
}
local var_0_2 = {
	"activityId",
	"puzzleId"
}
local var_0_3 = {
	extStarDesc = 2,
	puzzleTxt = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
