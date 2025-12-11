module("modules.configs.excel2json.lua_hero_story_mode_fugaoren_base", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	costTime = 4,
	areaId = 5,
	preId = 7,
	type = 3,
	name = 2,
	id = 1,
	storyId = 12,
	resource = 15,
	unlockAreaId = 6,
	rightChoose = 14,
	weather = 16,
	endTime = 10,
	conArea = 8,
	dialogId = 11,
	choose = 13,
	startTime = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	choose = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
