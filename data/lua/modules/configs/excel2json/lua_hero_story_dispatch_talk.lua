﻿module("modules.configs.excel2json.lua_hero_story_dispatch_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	speaker = 5,
	id = 1,
	heroid = 6,
	type = 2,
	color = 4,
	content = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 1,
	speaker = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
