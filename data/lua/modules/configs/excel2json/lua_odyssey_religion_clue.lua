module("modules.configs.excel2json.lua_odyssey_religion_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	unlockCondition = 3,
	clue = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	clue = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
