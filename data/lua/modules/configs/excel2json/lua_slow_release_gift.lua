module("modules.configs.excel2json.lua_slow_release_gift", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	onceBonus = 3,
	desc2 = 6,
	dailyBonus = 4,
	days = 2,
	id = 1,
	desc1 = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 2,
	desc1 = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
