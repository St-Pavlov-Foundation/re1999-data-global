module("modules.configs.excel2json.lua_activity157_mission", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	groupId = 3,
	area = 9,
	storyId = 7,
	linePrefab = 8,
	pos = 6,
	elementId = 5,
	missionId = 2,
	activityId = 1,
	order = 4
}
local var_0_2 = {
	"activityId",
	"missionId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
