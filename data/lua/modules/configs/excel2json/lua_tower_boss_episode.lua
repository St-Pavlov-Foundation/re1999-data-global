module("modules.configs.excel2json.lua_tower_boss_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	layerId = 2,
	firstReward = 7,
	bossLevel = 6,
	preLayerId = 3,
	episodeId = 5,
	openRound = 4,
	towerId = 1
}
local var_0_2 = {
	"towerId",
	"layerId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
