module("modules.configs.excel2json.lua_bonus", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dailyGainLimit = 2,
	fixBonus = 6,
	score = 5,
	heroExp = 3,
	id = 1,
	bonusView = 7,
	dailyGainWarning = 8,
	playerExp = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
