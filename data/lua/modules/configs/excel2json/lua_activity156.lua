﻿module("modules.configs.excel2json.lua_activity156", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	targetFrequency = 7,
	name = 8,
	preId = 3,
	musictime = 11,
	openDay = 4,
	time = 12,
	text = 9,
	initFrequency = 6,
	id = 2,
	frequency = 5,
	activityId = 1,
	bonus = 10
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	text = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
