module("modules.configs.excel2json.lua_chapter", package.seeall)

slot1 = {
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
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	year = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
