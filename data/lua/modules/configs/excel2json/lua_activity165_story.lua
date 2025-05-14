module("modules.configs.excel2json.lua_activity165_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyId = 2,
	unlockElementIds2 = 7,
	firstUnlockElementCd2 = 8,
	preElementId1 = 3,
	firstUnlockElementCd1 = 5,
	unlockElementIds1 = 4,
	pic = 11,
	name = 10,
	firstStepId = 9,
	preElementId2 = 6,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"storyId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
