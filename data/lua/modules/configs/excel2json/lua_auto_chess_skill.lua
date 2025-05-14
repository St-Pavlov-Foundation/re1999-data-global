module("modules.configs.excel2json.lua_auto_chess_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effect1 = 6,
	triggerPoint1 = 5,
	totalTriggerLimit1 = 8,
	totalTriggerLimit3 = 18,
	effect3 = 16,
	triggerPoint2 = 10,
	roundTriggerLimit1 = 7,
	condition3 = 14,
	skillaction = 19,
	skilleffID = 21,
	useeffect = 20,
	tag = 2,
	condition2 = 9,
	effect2 = 11,
	triggerPoint3 = 15,
	roundTriggerLimit2 = 12,
	countdown = 3,
	totalTriggerLimit2 = 13,
	roundTriggerLimit3 = 17,
	condition1 = 4,
	id = 1,
	downline = 22
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
