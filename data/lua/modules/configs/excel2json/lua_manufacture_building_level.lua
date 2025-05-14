module("modules.configs.excel2json.lua_manufacture_building_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 4,
	effect = 3,
	id = 2,
	productions = 5,
	groupId = 1,
	needTradeLevel = 6,
	slotCount = 7
}
local var_0_2 = {
	"groupId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
