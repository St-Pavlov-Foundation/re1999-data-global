module("modules.configs.excel2json.lua_buff_act", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 7,
	effect = 5,
	effectHangPoint = 6,
	type = 2,
	id = 1,
	effectCondition = 4,
	effectTime = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
