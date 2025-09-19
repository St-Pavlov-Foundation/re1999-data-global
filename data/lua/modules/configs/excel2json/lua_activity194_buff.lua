module("modules.configs.excel2json.lua_activity194_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectDesc = 4,
	buffType = 2,
	buffId = 1,
	effectType = 3
}
local var_0_2 = {
	"buffId"
}
local var_0_3 = {
	effectDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
