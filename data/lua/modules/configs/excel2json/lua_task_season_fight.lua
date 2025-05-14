module("modules.configs.excel2json.lua_task_season_fight", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fightId = 3,
	seasonId = 2,
	params = 5,
	id = 1,
	desc = 4
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
