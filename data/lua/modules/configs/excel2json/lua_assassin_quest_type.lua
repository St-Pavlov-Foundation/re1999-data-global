module("modules.configs.excel2json.lua_assassin_quest_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 3,
	name = 2,
	type = 1
}
local var_0_2 = {
	"type"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
