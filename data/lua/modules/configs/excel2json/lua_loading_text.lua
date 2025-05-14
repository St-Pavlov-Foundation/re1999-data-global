module("modules.configs.excel2json.lua_loading_text", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlocklevel = 2,
	titleen = 5,
	content = 6,
	id = 1,
	title = 4,
	weight = 3,
	scenes = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
