module("modules.configs.excel2json.lua_activity104_equip_attr", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dropDmg = 11,
	def = 4,
	cri = 6,
	defenseIgnore = 14,
	atk = 3,
	normalSkillRate = 17,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	criDef = 9,
	clutch = 16,
	attrId = 1,
	absorb = 15,
	revive = 13,
	recri = 7,
	hp = 2,
	heal = 12
}
local var_0_2 = {
	"attrId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
