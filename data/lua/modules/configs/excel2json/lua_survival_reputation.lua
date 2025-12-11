module("modules.configs.excel2json.lua_survival_reputation", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 4,
	name = 6,
	reward = 7,
	type = 3,
	id = 1,
	icon = 5,
	lv = 2
}
local var_0_2 = {
	"id",
	"lv"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
