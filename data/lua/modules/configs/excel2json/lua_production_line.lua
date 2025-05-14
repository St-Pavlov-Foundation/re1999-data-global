module("modules.configs.excel2json.lua_production_line", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reserve = 5,
	name = 2,
	logic = 4,
	type = 3,
	id = 1,
	initFormula = 6,
	needRoomLevel = 8,
	levelGroup = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
