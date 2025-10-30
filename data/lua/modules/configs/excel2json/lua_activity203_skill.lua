module("modules.configs.excel2json.lua_activity203_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	description = 4,
	name = 3,
	coolDown = 7,
	skillId = 1,
	effect = 6,
	icon = 5,
	target = 2
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {
	description = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
