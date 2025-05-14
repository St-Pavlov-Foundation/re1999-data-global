module("modules.configs.excel2json.lua_character_destiny_facets", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	level = 2,
	desc = 5,
	powerAdd = 3,
	facetsId = 1,
	exchangeSkills = 4
}
local var_0_2 = {
	"facetsId",
	"level"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
