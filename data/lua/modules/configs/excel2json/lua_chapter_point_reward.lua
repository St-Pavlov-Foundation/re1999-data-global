module("modules.configs.excel2json.lua_chapter_point_reward", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 4,
	display = 6,
	unlockChapter = 5,
	chapterId = 2,
	id = 1,
	rewardPointNum = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
