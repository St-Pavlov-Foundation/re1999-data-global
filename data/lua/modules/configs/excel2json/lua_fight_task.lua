module("modules.configs.excel2json.lua_fight_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	taskParam1 = 3,
	taskParam2 = 5,
	sysParam4 = 10,
	taskParam3 = 7,
	condition = 2,
	taskParam4 = 9,
	sysParam2 = 6,
	sysParam1 = 4,
	id = 1,
	sysParam3 = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
