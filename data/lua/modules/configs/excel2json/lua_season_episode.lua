module("modules.configs.excel2json.lua_season_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	buffName = 6,
	name = 3,
	desc = 7,
	waveScoreRate = 9,
	openDate = 4,
	seasonEpisodeId = 2,
	id = 1,
	icon = 8,
	gradeCondition = 5
}
local var_0_2 = {
	"id",
	"seasonEpisodeId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
