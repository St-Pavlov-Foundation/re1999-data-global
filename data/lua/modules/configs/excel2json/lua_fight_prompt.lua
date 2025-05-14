module("modules.configs.excel2json.lua_fight_prompt", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	color = 3,
	content = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
