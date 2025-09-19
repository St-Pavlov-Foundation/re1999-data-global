module("modules.configs.excel2json.lua_activity194_game", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	maxRoundLimit = 5,
	winCondition = 7,
	extraConditionStr = 10,
	eventGroup = 4,
	winConditionStr = 8,
	startEnergy = 6,
	initialItem = 3,
	extraCondition = 9,
	initialTeam = 2,
	gameId = 1
}
local var_0_2 = {
	"gameId"
}
local var_0_3 = {
	extraConditionStr = 2,
	winConditionStr = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
