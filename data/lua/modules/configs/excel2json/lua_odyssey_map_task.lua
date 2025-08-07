module("modules.configs.excel2json.lua_odyssey_map_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	elementList = 2,
	taskDesc = 4,
	taskTitle = 3,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	taskTitle = 1,
	taskDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
