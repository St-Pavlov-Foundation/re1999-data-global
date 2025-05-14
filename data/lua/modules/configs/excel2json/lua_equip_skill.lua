module("modules.configs.excel2json.lua_equip_skill", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	skill = 3,
	skill2 = 4,
	skillHide = 5,
	dropDmg = 16,
	heal = 17,
	defenseIgnore = 19,
	career = 6,
	absorb = 20,
	addDmg = 15,
	normalSkillRate = 21,
	baseDesc = 7,
	criDmg = 13,
	attack = 9,
	criDef = 14,
	clutch = 22,
	skillLv = 2,
	baseDesc2 = 23,
	cri = 11,
	revive = 18,
	recri = 12,
	condition = 8,
	hp = 10,
	id = 1
}
local var_0_2 = {
	"id",
	"skillLv"
}
local var_0_3 = {
	baseDesc = 1,
	baseDesc2 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
