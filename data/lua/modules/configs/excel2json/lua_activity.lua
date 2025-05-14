module("modules.configs.excel2json.lua_activity", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tabBgPath = 25,
	name = 3,
	logoType = 8,
	banner = 13,
	achievementGroupPath = 23,
	tryoutEpisode = 33,
	tabButton = 26,
	openId = 17,
	achievementGroup = 19,
	hintPriority = 30,
	permanentParentAcitivityId = 22,
	showCenter = 15,
	redDotId = 18,
	extraDisplayIcon = 32,
	isRetroAcitivity = 21,
	actTip = 6,
	id = 1,
	nameEn = 4,
	logoName = 9,
	actDesc = 5,
	achievementJumpId = 28,
	desc = 14,
	confirmCondition = 11,
	tabBgmId = 27,
	extraDisplayId = 31,
	param = 16,
	defaultPriority = 29,
	storyId = 20,
	typeId = 7,
	activityBonus = 24,
	tabName = 2,
	tryoutcharacter = 34,
	joinCondition = 10,
	displayPriority = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	logoName = 5,
	name = 2,
	actDesc = 3,
	tabName = 1,
	actTip = 4,
	desc = 6
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
