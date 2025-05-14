module("modules.configs.excel2json.lua_activity128_stage", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 7,
	name = 3,
	name_en = 4,
	bossRushLevelDetailFullBgSimage = 9,
	maxPoints = 5,
	resultViewFullBgSImage = 10,
	skinIds = 12,
	bossRushMainItemBossSprite = 8,
	skinScales = 13,
	skinOffsetXYs = 14,
	resultViewNameSImage = 11,
	layer4MaxPoints = 6,
	stage = 2,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"stage"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
