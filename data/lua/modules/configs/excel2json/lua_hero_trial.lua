module("modules.configs.excel2json.lua_hero_trial", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	exSkillLv = 7,
	act104EquipId2 = 13,
	attrId = 14,
	facetsId = 15,
	equipRefine = 11,
	skin = 4,
	trialTemplate = 2,
	heroId = 3,
	trialType = 5,
	talent = 8,
	equipId = 9,
	act104EquipId1 = 12,
	id = 1,
	facetslevel = 16,
	equipLv = 10,
	level = 6
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
