module("modules.configs.excel2json.lua_key_binding", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
local var_0_2 = {
	"hud",
	"id"
}
local var_0_3 = {
	description = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
