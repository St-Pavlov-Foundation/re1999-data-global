module("modules.configs.excel2json.lua_chapter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 5,
	name = 2,
	chapterpic = 7,
	type = 8,
	ambientMusic = 23,
	saveHeroGroup = 20,
	openLevel = 11,
	rewardPoint = 12,
	elementList = 14,
	navigationIcon = 21,
	canUseDouble = 16,
	rewindChapterBg = 22,
	name_En = 4,
	canPlayOpenMv = 15,
	isHeroRecommend = 24,
	challengeCountLimit = 19,
	openDay = 10,
	enterAfterFreeLimit = 18,
	episodeId = 26,
	chapterIndex = 3,
	canReturn = 9,
	year = 6,
	canMakeTeam = 17,
	id = 1,
	actId = 25,
	preChapter = 13
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
