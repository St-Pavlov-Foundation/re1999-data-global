module("modules.configs.excel2json.lua_handbook_story_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nameEn = 6,
	name = 5,
	time = 8,
	date = 7,
	episodeId = 4,
	image = 13,
	fragmentIdList = 12,
	storyChapterId = 3,
	storyIdList = 10,
	levelIdDict = 11,
	year = 9,
	id = 1,
	order = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
