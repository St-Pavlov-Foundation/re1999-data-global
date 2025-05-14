module("modules.configs.excel2json.lua_activity163_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	expression = 9,
	content = 7,
	nextStep = 3,
	pos = 5,
	stepId = 2,
	condition = 8,
	speaker = 4,
	speakerIcon = 6,
	id = 1
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	speaker = 1,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
