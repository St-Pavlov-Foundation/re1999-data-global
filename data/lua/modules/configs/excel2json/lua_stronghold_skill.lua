module("modules.configs.excel2json.lua_stronghold_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 3,
	effect = 4,
	roundTriggerCountLimit = 5,
	skillId = 1,
	totalTriggerCountLimit = 6,
	condition = 2
}
local var_0_2 = {
	"skillId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
