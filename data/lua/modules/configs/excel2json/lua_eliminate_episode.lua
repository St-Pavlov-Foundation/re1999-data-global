module("modules.configs.excel2json.lua_eliminate_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	eliminateLevelId = 7,
	name = 2,
	chapterId = 5,
	preEpisode = 6,
	dialogueId = 9,
	posIndex = 4,
	levelPosition = 3,
	warChessId = 8,
	id = 1,
	aniPos = 10
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
