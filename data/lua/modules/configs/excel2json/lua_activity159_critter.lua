module("modules.configs.excel2json.lua_activity159_critter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 1,
	startPos = 4,
	res = 2,
	anim = 3,
	scale = 5
}
local var_0_2 = {
	"name"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
