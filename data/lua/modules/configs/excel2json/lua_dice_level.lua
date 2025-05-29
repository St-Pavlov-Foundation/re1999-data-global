module("modules.configs.excel2json.lua_dice_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	chapter = 3,
	enemyType = 6,
	isSkip = 10,
	type = 5,
	rewardSelectType = 8,
	mode = 7,
	room = 4,
	dialog = 9,
	id = 1,
	chapterName = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	chapterName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
