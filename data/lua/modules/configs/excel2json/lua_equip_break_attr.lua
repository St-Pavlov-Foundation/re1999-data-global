module("modules.configs.excel2json.lua_equip_break_attr", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dropDmg = 12,
	def = 5,
	cri = 7,
	defenseIgnore = 15,
	id = 1,
	normalSkillRate = 17,
	mdef = 6,
	addDmg = 11,
	criDmg = 9,
	attack = 3,
	criDef = 10,
	clutch = 18,
	absorb = 16,
	revive = 14,
	recri = 8,
	hp = 4,
	breakLevel = 2,
	heal = 13
}
local var_0_2 = {
	"id",
	"breakLevel"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
