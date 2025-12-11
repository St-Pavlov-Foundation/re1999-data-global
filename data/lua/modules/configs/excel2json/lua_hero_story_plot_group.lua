module("modules.configs.excel2json.lua_hero_story_plot_group", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	storyPic = 9,
	time = 5,
	storyNameEn = 4,
	storyId = 2,
	place = 6,
	roleName = 8,
	isEnd = 10,
	weather = 7,
	storyName = 3,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	roleName = 3,
	place = 2,
	storyName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
