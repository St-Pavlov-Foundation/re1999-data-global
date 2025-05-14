module("modules.configs.excel2json.lua_rogue_event_drop_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 5,
	iconbg = 6,
	type = 1,
	id = 2,
	title = 3,
	desc = 4
}
local var_0_2 = {
	"type",
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
