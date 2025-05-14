module("modules.configs.excel2json.lua_push_box_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	fan_duration = 8,
	name = 2,
	enemy_alarm = 7,
	layout = 3,
	light_alarm = 9,
	enemy_act = 6,
	id = 1,
	wall = 4,
	step = 5
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
