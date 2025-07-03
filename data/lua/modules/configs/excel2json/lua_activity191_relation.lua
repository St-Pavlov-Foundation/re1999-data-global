module("modules.configs.excel2json.lua_activity191_relation", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activeNum = 6,
	name = 3,
	levelDesc = 8,
	tag = 2,
	tagBg = 5,
	desc = 7,
	effects = 9,
	id = 1,
	icon = 10,
	level = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	levelDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
