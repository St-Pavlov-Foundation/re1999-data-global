module("modules.configs.excel2json.lua_stance_hp_offset", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	offsetPos8 = 9,
	offsetPos4 = 5,
	offsetPos1 = 2,
	offsetPos7 = 8,
	offsetPos3 = 4,
	id = 1,
	offsetPos5 = 6,
	offsetPos6 = 7,
	offsetPos2 = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
