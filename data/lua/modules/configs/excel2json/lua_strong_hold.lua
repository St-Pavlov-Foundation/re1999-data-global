module("modules.configs.excel2json.lua_strong_hold", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	ruleId = 7,
	name = 2,
	eliminateBg = 3,
	id = 1,
	strongholdBg = 4,
	friendCapacity = 6,
	enemyCapacity = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
