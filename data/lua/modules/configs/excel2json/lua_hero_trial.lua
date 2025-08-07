module("modules.configs.excel2json.lua_hero_trial", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	equipRefine = 11,
	act104EquipId2 = 13,
	facetsId = 15,
	skin = 4,
	equipId = 9,
	heroId = 3,
	act104EquipId1 = 12,
	exSkillLv = 7,
	level = 6,
	attrId = 14,
	facetslevel = 16,
	trialTemplate = 2,
	trialType = 5,
	talent = 8,
	special = 17,
	id = 1,
	equipLv = 10
}
local var_0_2 = {
	"id",
	"trialTemplate"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
