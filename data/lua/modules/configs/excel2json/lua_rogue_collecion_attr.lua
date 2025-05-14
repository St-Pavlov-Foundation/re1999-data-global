module("modules.configs.excel2json.lua_rogue_collecion_attr", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	revive = 13,
	def = 4,
	dropDmg = 11,
	defenseIgnore = 14,
	cri = 6,
	id = 1,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	attack = 3,
	criDef = 9,
	clutch = 17,
	absorb = 15,
	normalSkillRate = 16,
	recri = 7,
	hp = 2,
	heal = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
