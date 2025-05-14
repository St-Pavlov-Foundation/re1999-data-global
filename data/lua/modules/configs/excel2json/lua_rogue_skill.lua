module("modules.configs.excel2json.lua_rogue_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	num = 2,
	desc = 6,
	skills = 5,
	id = 1,
	icon = 3,
	attr = 4
}
local var_0_2 = {
	"id",
	"num"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
