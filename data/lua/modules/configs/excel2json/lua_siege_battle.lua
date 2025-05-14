module("modules.configs.excel2json.lua_siege_battle", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stage = 2,
	heroId = 5,
	instructionDesc = 6,
	episodeId = 7,
	id = 1,
	unlockCondition = 4,
	sort = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	instructionDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
