module("modules.configs.excel2json.lua_activity122_character", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	pushOverObstacle = 7,
	fireDecrHp = 6,
	trapDecrHp = 5,
	destroyObstacle = 4,
	moveObstacle = 3,
	characterType = 2
}
local var_0_2 = {
	"activityId",
	"characterType"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
