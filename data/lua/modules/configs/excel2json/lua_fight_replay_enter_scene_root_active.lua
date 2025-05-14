module("modules.configs.excel2json.lua_fight_replay_enter_scene_root_active", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	wave = 2,
	id = 1,
	activeRootName = 3,
	switch = 4
}
local var_0_2 = {
	"id",
	"wave"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
