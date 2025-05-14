module("modules.configs.excel2json.lua_equip_break_cost", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 4,
	scoreCost = 5,
	breakLevel = 2,
	rare = 1,
	level = 3
}
local var_0_2 = {
	"rare",
	"breakLevel"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
