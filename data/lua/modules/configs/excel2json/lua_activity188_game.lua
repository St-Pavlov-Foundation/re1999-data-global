module("modules.configs.excel2json.lua_activity188_game", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossAbilityPool = 10,
	activityId = 1,
	count = 13,
	portrait = 19,
	abilityIds = 5,
	passRound = 18,
	bossCount = 14,
	bossAbilityIds = 6,
	bossHurt = 16,
	abilityPool = 9,
	bossHp = 12,
	rowColumn = 7,
	round = 3,
	hurt = 15,
	hp = 11,
	cardBuild = 8,
	id = 2,
	difficult = 17,
	readNum = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
