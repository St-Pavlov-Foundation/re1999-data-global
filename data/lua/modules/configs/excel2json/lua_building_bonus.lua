module("modules.configs.excel2json.lua_building_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bonus = 2,
	characterLimitAdd = 3,
	buildDegree = 1
}
local var_0_2 = {
	"buildDegree"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
