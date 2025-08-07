module("modules.configs.excel2json.lua_odyssey_equip_suit_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	addRule = 5,
	effect = 6,
	number = 3,
	id = 1,
	addSkill = 4,
	level = 2
}
local var_0_2 = {
	"id",
	"level"
}
local var_0_3 = {
	effect = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
