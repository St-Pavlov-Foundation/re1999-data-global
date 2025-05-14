module("modules.configs.excel2json.lua_fight_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	career3 = 4,
	career5 = 6,
	career2 = 3,
	career6 = 7,
	id = 1,
	career1 = 2,
	career4 = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
