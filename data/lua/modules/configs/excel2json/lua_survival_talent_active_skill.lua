module("modules.configs.excel2json.lua_survival_talent_active_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	roundLimit = 2,
	skillId = 6,
	icon = 7,
	maxLimit = 4,
	id = 1,
	coldTime = 3,
	desc = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
