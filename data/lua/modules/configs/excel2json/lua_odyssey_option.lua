module("modules.configs.excel2json.lua_odyssey_option", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 6,
	id = 1,
	story = 8,
	subDesc = 5,
	notFinish = 3,
	unlockCondition = 2,
	dataBase = 7,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	subDesc = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
