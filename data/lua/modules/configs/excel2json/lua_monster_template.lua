module("modules.configs.excel2json.lua_monster_template", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	defense = 5,
	mdefense = 6,
	technic = 7,
	dropDmg = 13,
	criDmg = 10,
	criGrow = 19,
	criDefGrow = 22,
	technicGrow = 18,
	addDmg = 12,
	addDmgGrow = 23,
	recriGrow = 20,
	attackGrow = 15,
	attack = 4,
	criDef = 11,
	mdefenseGrow = 17,
	defenseGrow = 16,
	dropDmgGrow = 24,
	cri = 8,
	multiHp = 3,
	recri = 9,
	template = 1,
	life = 2,
	lifeGrow = 14,
	criDmgGrow = 21
}
local var_0_2 = {
	"template"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
