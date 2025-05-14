module("modules.configs.excel2json.lua_turnback_drop", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerParam = 5,
	name = 3,
	jumpId = 6,
	type = 4,
	id = 1,
	picPath = 7,
	level = 2
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
