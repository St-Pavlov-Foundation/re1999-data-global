module("modules.configs.excel2json.lua_activity163_evidence", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	evidenceId = 1,
	showFusion = 7,
	tips = 6,
	errorTip = 5,
	conditionStr = 4,
	puzzleTxt = 3,
	dialogGroupType = 2
}
local var_0_2 = {
	"evidenceId"
}
local var_0_3 = {
	conditionStr = 2,
	puzzleTxt = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
