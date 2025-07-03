module("modules.configs.excel2json.lua_activity191_ex_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 3,
	monsterId = 1,
	skillLevel = 2
}
local var_0_2 = {
	"monsterId",
	"skillLevel"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
