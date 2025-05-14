module("modules.configs.excel2json.lua_activity144_round", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isPass = 4,
	keepMaterialRate = 6,
	round = 3,
	name = 7,
	actionPoint = 5,
	activityId = 1,
	episodeId = 2
}
local var_0_2 = {
	"activityId",
	"episodeId",
	"round"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
