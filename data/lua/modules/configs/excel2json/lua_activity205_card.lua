module("modules.configs.excel2json.lua_activity205_card", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	restrain = 6,
	name = 3,
	type = 2,
	subWeight = 9,
	desc = 4,
	img = 5,
	id = 1,
	spEff = 7,
	weight = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
