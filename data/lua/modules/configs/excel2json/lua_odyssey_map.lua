module("modules.configs.excel2json.lua_odyssey_map", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	unlockCondition = 2,
	res = 3,
	mapName = 5,
	recommendLevel = 6,
	id = 1,
	initPos = 4,
	unlockDesc = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	unlockDesc = 2,
	mapName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
