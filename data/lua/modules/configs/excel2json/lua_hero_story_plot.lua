module("modules.configs.excel2json.lua_hero_story_plot", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	addControl = 8,
	name = 5,
	param = 4,
	type = 3,
	controlParam = 10,
	desc = 6,
	controlDelay = 9,
	pause = 7,
	id = 1,
	storygroup = 2,
	level = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
