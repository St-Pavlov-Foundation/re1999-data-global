module("modules.configs.excel2json.lua_activity116_episode_sp", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	endShow = 5,
	id = 1,
	title = 3,
	refreshDay = 2,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	endShow = 3,
	title = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
