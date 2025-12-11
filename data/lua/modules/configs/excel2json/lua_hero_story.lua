module("modules.configs.excel2json.lua_hero_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	episodeId = 12,
	name = 9,
	nameEn = 10,
	chapterId = 2,
	order = 8,
	activity_pic = 17,
	cgUnlockEpisodeId = 18,
	unlock = 3,
	cgPos = 20,
	heroName = 5,
	cgUnlockStoryId = 19,
	mainviewName = 22,
	permanentUnlock = 23,
	signature = 24,
	activityId = 16,
	queryVersion = 11,
	challengeBonus = 15,
	cgBg = 7,
	cgScale = 21,
	photo = 6,
	id = 1,
	main_pic = 13,
	monster_pic = 14,
	bonus = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	heroName = 1,
	mainviewName = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
