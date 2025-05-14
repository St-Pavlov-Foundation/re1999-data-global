module("modules.configs.excel2json.lua_activity157_mission_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type = 3,
	mapName = 4,
	activityId = 1,
	missionGroupId = 2
}
local var_0_2 = {
	"activityId",
	"missionGroupId"
}
local var_0_3 = {
	mapName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
