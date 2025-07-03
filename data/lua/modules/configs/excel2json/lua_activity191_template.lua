module("modules.configs.excel2json.lua_activity191_template", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	defense = 4,
	id = 1,
	technic = 6,
	life = 2,
	attack = 3,
	mdefense = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
