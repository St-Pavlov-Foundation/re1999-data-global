module("modules.configs.excel2json.lua_critter_attribute_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 3,
	minValue = 2,
	icon = 4,
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
