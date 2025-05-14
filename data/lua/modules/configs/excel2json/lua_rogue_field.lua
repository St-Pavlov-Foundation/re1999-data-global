module("modules.configs.excel2json.lua_rogue_field", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 2,
	equipLevel = 6,
	level6 = 5,
	level4 = 3,
	level5 = 4,
	talentLevel = 7,
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
