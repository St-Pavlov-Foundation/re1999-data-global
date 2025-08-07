module("modules.configs.excel2json.lua_assassin_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	buffEffect = 4,
	effectId = 5,
	buffId = 1,
	type = 2,
	duration = 3
}
local var_0_2 = {
	"buffId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
