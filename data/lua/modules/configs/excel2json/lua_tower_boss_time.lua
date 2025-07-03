module("modules.configs.excel2json.lua_tower_boss_time", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	taskEndTime = 7,
	isOnline = 8,
	isPermanent = 3,
	endTime = 5,
	startTime = 4,
	taskGroupId = 6,
	round = 2,
	towerId = 1
}
local var_0_2 = {
	"towerId",
	"round"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
