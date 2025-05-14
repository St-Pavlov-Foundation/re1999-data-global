module("modules.configs.excel2json.lua_bp_des", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	iconType = 4,
	bpId = 2,
	type = 3,
	id = 1,
	icon = 6,
	items = 5,
	des = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	des = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
