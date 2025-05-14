module("modules.configs.excel2json.lua_skill_behavior", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 5,
	effect = 3,
	id = 1,
	type = 2,
	effectHangPoint = 4,
	dec_Type = 6,
	dec = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	dec = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
