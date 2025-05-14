module("modules.configs.excel2json.lua_activity166_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activityId = 1,
	name = 3,
	baseSkillIds = 6,
	baseSkillIds2 = 7,
	sortIndex = 8,
	icon = 5,
	talentId = 2,
	nameEn = 4
}
local var_0_2 = {
	"activityId",
	"talentId"
}
local var_0_3 = {
	nameEn = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
