module("modules.configs.excel2json.lua_soldier_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 9,
	effect = 10,
	growUpTime = 6,
	type = 4,
	roundTriggerCountLimit = 11,
	condition = 8,
	skillDes = 3,
	totalTriggerCountLimit = 12,
	growUploop = 7,
	skillId = 1,
	skillName = 2,
	active = 5
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {
	skillDes = 2,
	skillName = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
