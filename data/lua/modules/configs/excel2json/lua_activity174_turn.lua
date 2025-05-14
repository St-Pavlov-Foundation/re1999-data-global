module("modules.configs.excel2json.lua_activity174_turn", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	groupNum = 7,
	name = 6,
	turn = 2,
	activityId = 1,
	endless = 9,
	shopLevel = 8,
	bag = 5,
	matchCoin = 11,
	point = 10,
	coin = 3,
	winCoin = 4
}
local var_0_2 = {
	"activityId",
	"turn"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
