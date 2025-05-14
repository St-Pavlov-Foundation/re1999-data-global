module("modules.configs.excel2json.lua_activity106_minigame", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	minBlock = 2,
	blockCount = 4,
	victoryRound = 5,
	randomLength = 6,
	id = 1,
	levelTime = 3,
	matPool = 8,
	pointerSpeed = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
