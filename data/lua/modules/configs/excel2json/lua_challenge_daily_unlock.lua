﻿module("modules.configs.excel2json.lua_challenge_daily_unlock", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	groupId = 1,
	unlock = 2
}
local var_0_2 = {
	"groupId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
