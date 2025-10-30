module("modules.configs.excel2json.lua_activity203_base", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dispatchInterval = 7,
	name = 2,
	initialCamp = 6,
	type = 4,
	baseId = 1,
	picture = 3,
	isHQ = 5,
	initialSoldier = 8,
	soldierRecover = 9,
	soldierLimit = 10
}
local var_0_2 = {
	"baseId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
