module("modules.configs.excel2json.lua_activity191_summon", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	monsterId = 6,
	name = 4,
	priority = 2,
	relation = 9,
	headIcon = 7,
	career = 5,
	summonType = 3,
	id = 1,
	icon = 8
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
