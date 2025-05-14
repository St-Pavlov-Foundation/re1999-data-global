module("modules.configs.excel2json.lua_achievement_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	uiListParam = 6,
	name = 4,
	desc = 5,
	category = 2,
	id = 1,
	unLockAchievement = 8,
	uiPlayerParam = 7,
	order = 3
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
