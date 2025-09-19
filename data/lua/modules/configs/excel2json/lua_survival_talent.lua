module("modules.configs.excel2json.lua_survival_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 4,
	name = 6,
	groupId = 2,
	seasons = 5,
	id = 1,
	desc1 = 7,
	pos = 3,
	desc2 = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
