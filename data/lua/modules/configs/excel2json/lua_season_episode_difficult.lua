module("modules.configs.excel2json.lua_season_episode_difficult", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	buffPool = 10,
	recommendLevel = 5,
	unlockDesc = 9,
	multiple = 6,
	ponitCondition = 11,
	seasonEpisodeId = 2,
	battleId = 4,
	difficult = 3,
	unlockDifficult = 7,
	unlockScore = 8
}
local var_0_2 = {
	"id",
	"seasonEpisodeId",
	"difficult"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
