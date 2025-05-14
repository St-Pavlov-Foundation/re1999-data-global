module("modules.configs.excel2json.lua_activity157_factory_component", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	componentId = 2,
	preComponentId = 4,
	unlockCondition = 3,
	elementId = 6,
	nextComponentId = 5,
	bonusForShow = 8,
	bonusBuildingLevel = 9,
	activityId = 1,
	bonus = 7
}
local var_0_2 = {
	"activityId",
	"componentId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
