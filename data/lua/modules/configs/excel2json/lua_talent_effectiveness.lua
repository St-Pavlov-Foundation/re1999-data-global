module("modules.configs.excel2json.lua_talent_effectiveness", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	sr = 3,
	ssr = 2,
	r = 4,
	level = 1
}
local var_0_2 = {
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
