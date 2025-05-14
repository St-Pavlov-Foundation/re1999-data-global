module("modules.configs.excel2json.lua_rogue_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	text = 3,
	id = 2,
	photo = 5,
	type = 4,
	group = 1
}
local var_0_2 = {
	"group",
	"id"
}
local var_0_3 = {
	text = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
