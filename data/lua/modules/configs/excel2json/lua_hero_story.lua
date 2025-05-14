module("modules.configs.excel2json.lua_hero_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
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
