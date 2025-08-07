module("modules.configs.excel2json.lua_character_destiny_facets_consume", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tend = 4,
	name = 2,
	consume = 3,
	facetsId = 1,
	facetsSort = 6,
	icon = 5
}
local var_0_2 = {
	"facetsId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
