module("modules.configs.excel2json.lua_activity168_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effectParams = 3,
	effectType = 2,
	desc = 4,
	effectId = 1
}
local var_0_2 = {
	"effectId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
