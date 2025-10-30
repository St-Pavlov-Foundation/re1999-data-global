module("modules.configs.excel2json.lua_activity203_passiveskill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	description = 3,
	passive_skillid = 1,
	name = 2,
	effect = 4
}
local var_0_2 = {
	"passive_skillid"
}
local var_0_3 = {
	description = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
