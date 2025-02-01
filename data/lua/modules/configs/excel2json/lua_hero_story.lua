module("modules.configs.excel2json.lua_hero_story", package.seeall)

slot1 = {
	activity_pic = 16,
	name = 9,
	nameEn = 10,
	chapterId = 2,
	episodeId = 11,
	cgUnlockEpisodeId = 17,
	cgPos = 18,
	unlock = 3,
	mainviewName = 20,
	heroName = 5,
	permanentUnlock = 21,
	activityId = 15,
	order = 8,
	challengeBonus = 14,
	cgBg = 7,
	cgScale = 19,
	photo = 6,
	id = 1,
	main_pic = 12,
	monster_pic = 13,
	bonus = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	heroName = 1,
	mainviewName = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
