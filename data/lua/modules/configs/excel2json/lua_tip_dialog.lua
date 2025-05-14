module("modules.configs.excel2json.lua_tip_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stepId = 2,
	content = 6,
	audio = 7,
	type = 3,
	id = 1,
	icon = 5,
	pos = 4
}
local var_0_2 = {
	"id",
	"stepId"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
