module("modules.configs.excel2json.lua_character_destiny", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	facetsId = 3,
	heroId = 1,
	slotsId = 2
}
local var_0_2 = {
	"heroId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
