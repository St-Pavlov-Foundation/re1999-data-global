module("modules.configs.excel2json.lua_turnback_task_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	needPoint = 6,
	character = 4,
	id = 2,
	turnbackId = 1,
	content = 5,
	bonus = 3
}
local var_0_2 = {
	"turnbackId",
	"id"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
