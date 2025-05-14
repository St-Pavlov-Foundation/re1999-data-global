module("modules.configs.excel2json.lua_rouge_layer", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	version = 2,
	name = 3,
	ruleIdVersion = 5,
	unlockType = 10,
	levelId = 22,
	pathPos = 17,
	iconPos = 18,
	desc = 13,
	bgm = 20,
	crossDesc = 14,
	sceneId = 21,
	ruleIdInstead = 6,
	startStoryId = 8,
	endStoryId = 9,
	mapRes = 7,
	middleLayerId = 4,
	unlockParam = 11,
	iconRes = 15,
	dayOrNight = 19,
	id = 1,
	pathRes = 16,
	nameEn = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	crossDesc = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
