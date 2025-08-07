module("modules.configs.excel2json.lua_odyssey_dialog_element", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stepId = 2,
	name = 6,
	nextStep = 3,
	optionList = 5,
	id = 1,
	picture = 4,
	desc = 7
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
