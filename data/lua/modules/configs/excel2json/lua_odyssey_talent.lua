module("modules.configs.excel2json.lua_odyssey_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	position = 11,
	nodeId = 1,
	nodeName = 6,
	type = 5,
	unlockCondition = 4,
	addRule = 10,
	nodeDesc = 7,
	consume = 3,
	addSkill = 9,
	icon = 8,
	level = 2
}
local var_0_2 = {
	"nodeId",
	"level"
}
local var_0_3 = {
	nodeName = 1,
	nodeDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
