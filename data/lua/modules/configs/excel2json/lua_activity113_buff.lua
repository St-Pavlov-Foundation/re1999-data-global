module("modules.configs.excel2json.lua_activity113_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 7,
	name = 3,
	buffId = 2,
	taskId = 8,
	bigIcon = 10,
	desc = 4,
	preBuffId = 6,
	skillId = 5,
	id = 1,
	icon = 9
}
local var_0_2 = {
	"id",
	"buffId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
