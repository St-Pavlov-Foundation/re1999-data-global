﻿module("modules.configs.excel2json.lua_chapter_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	areaAudio = 8,
	effectAudio = 7,
	unlockCondition = 3,
	chapterId = 2,
	mapState = 9,
	initPos = 6,
	desc = 5,
	res = 4,
	id = 1
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
