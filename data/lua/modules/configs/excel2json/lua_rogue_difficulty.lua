module("modules.configs.excel2json.lua_rogue_difficulty", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effect1 = 15,
	initRoom = 5,
	effectDesc1 = 14,
	scoreAdd = 11,
	effect3 = 19,
	title = 2,
	initHeroCount = 12,
	effect2 = 17,
	effectDesc3 = 18,
	initCurrency = 6,
	initHeart = 7,
	difficulty = 1,
	preDifficulty = 3,
	attrAdd = 10,
	rule = 8,
	effectDesc2 = 16,
	showDifficulty = 9,
	retries = 13,
	initLevel = 4
}
local var_0_2 = {
	"difficulty"
}
local var_0_3 = {
	effectDesc1 = 2,
	title = 1,
	effectDesc3 = 4,
	effectDesc2 = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
