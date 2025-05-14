module("modules.configs.excel2json.lua_boss_action_list", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	actionId = 1,
	actionId3 = 5,
	actionId7 = 9,
	actionId4 = 6,
	actionId10 = 12,
	actionId5 = 7,
	actionId6 = 8,
	circle = 2,
	actionId8 = 10,
	actionId1 = 3,
	actionId9 = 11,
	actionId2 = 4
}
local var_0_2 = {
	"actionId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
