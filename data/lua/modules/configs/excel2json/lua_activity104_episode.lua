module("modules.configs.excel2json.lua_activity104_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	level = 8,
	stagePicture = 7,
	stageNameEn = 6,
	episodeId = 3,
	unlockEquipIndex = 9,
	afterStoryId = 11,
	desc = 12,
	stageName = 5,
	firstPassEquipId = 10,
	stage = 4,
	activityId = 1,
	layer = 2
}
local var_0_2 = {
	"activityId",
	"layer"
}
local var_0_3 = {
	desc = 2,
	stageName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
