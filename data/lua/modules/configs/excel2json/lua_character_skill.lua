module("modules.configs.excel2json.lua_character_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	triggerPoint = 8,
	name = 2,
	cost = 7,
	condition = 9,
	effect = 10,
	roundTriggerCountLimit = 11,
	skillPrompt = 4,
	desc = 3,
	totalTriggerCountLimit = 12,
	id = 1,
	icon = 5,
	active = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	skillPrompt = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
