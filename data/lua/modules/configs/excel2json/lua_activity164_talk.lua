﻿module("modules.configs.excel2json.lua_activity164_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content = 5,
	delay = 6,
	id = 2,
	headIcon = 4,
	activityId = 1,
	step = 3
}
local var_0_2 = {
	"activityId",
	"id",
	"step"
}
local var_0_3 = {
	content = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
