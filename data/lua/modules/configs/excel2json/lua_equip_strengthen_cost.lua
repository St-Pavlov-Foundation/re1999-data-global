module("modules.configs.excel2json.lua_equip_strengthen_cost", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	scoreCost = 4,
	attributeRate = 5,
	exp = 3,
	rare = 1,
	level = 2
}
local var_0_2 = {
	"rare",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
