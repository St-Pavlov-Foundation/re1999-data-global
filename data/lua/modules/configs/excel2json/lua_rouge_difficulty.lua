module("modules.configs.excel2json.lua_rouge_difficulty", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	title_en = 5,
	preDifficulty = 6,
	scoreReward = 8,
	startView = 9,
	season = 1,
	title = 4,
	initEffects = 11,
	desc = 12,
	monsterDesc = 7,
	balanceLevel = 13,
	initCollections = 10,
	version = 3,
	difficulty = 2
}
local var_0_2 = {
	"season",
	"difficulty"
}
local var_0_3 = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
