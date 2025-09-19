module("modules.configs.excel2json.lua_survival_behavior", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	chooseEvent = 6,
	priority = 3,
	chooseDesc = 5,
	condition = 2,
	id = 1,
	dialogueId = 4,
	isMark = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	chooseDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
