module("modules.configs.excel2json.lua_tower_assist_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	bossId = 1,
	nodeId = 2,
	startNode = 4,
	nodeType = 12,
	extraRule = 9,
	nodeName = 13,
	nodeGroup = 8,
	nodeDesc = 14,
	isBigNode = 11,
	consume = 5,
	heroPassiveSkills = 7,
	position = 10,
	preNodeIds = 3,
	bossPassiveSkills = 6
}
local var_0_2 = {
	"bossId",
	"nodeId"
}
local var_0_3 = {
	nodeName = 1,
	nodeDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
