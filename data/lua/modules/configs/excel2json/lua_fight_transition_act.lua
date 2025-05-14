module("modules.configs.excel2json.lua_fight_transition_act", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fromAct = 2,
	id = 1,
	endAct = 3,
	transitionAct = 4
}
local var_0_2 = {
	"id",
	"fromAct",
	"endAct"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
