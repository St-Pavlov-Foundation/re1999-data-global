module("modules.configs.excel2json.lua_v2a4_warmup_dialog", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fmt1 = 5,
	fmt3 = 7,
	fmt2 = 6,
	nextId = 4,
	group = 2,
	desc = 3,
	id = 1,
	fmt5 = 9,
	fmt4 = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
