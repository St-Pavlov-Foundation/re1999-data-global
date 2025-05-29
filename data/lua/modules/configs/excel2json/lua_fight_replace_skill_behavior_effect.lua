module("modules.configs.excel2json.lua_fight_replace_skill_behavior_effect", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	audioId = 5,
	effect = 3,
	id = 1,
	skillBehaviorId = 2,
	effectHangPoint = 4
}
local var_0_2 = {
	"id",
	"skillBehaviorId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
