﻿module("modules.configs.excel2json.lua_copost_scene", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	scene = 2,
	leftUpRange = 3,
	scene_ui = 5,
	scene_node = 6,
	id = 1,
	rightDownRange = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
