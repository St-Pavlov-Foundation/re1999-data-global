module("modules.configs.excel2json.lua_activity145_movement", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	displayTime = 5,
	type = 2,
	id = 1,
	motion = 3,
	content = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 2,
	motion = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
