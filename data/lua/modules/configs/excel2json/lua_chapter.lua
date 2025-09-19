module("modules.configs.excel2json.lua_chapter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 7,
	chapterpic = 9,
	name = 2,
	type = 10,
	ambientMusic = 25,
	challengeCountLimit = 21,
	openLevel = 13,
	rewardPoint = 14,
	elementList = 16,
	saveHeroGroup = 22,
	dramaModeToMainChapterld = 4,
	navigationIcon = 23,
	name_En = 6,
	canPlayOpenMv = 17,
	isHeroRecommend = 26,
	canUseDouble = 18,
	openDay = 12,
	enterAfterFreeLimit = 20,
	rewindChapterBg = 24,
	chapterIndex = 5,
	canReturn = 11,
	episodeId = 28,
	eaActivityId = 3,
	year = 8,
	canMakeTeam = 19,
	id = 1,
	actId = 27,
	preChapter = 15
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	year = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
