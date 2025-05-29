module("modules.configs.excel2json.lua_weekwalk_ver2_time", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	ruleFront = 5,
	ruleRear = 6,
	issueId = 2,
	ruleIcon = 4,
	optionalSkills = 3,
	timeId = 1
}
local var_0_2 = {
	"timeId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
