module("modules.configs.excel2json.lua_open_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	need_finish_guide = 6,
	hero_number = 2,
	need_episode = 4,
	need_enter_episode = 5,
	id = 1,
	showInEpisode = 7,
	need_level = 3,
	lock_desc = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
