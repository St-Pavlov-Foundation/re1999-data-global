module("modules.configs.excel2json.lua_talent_cube_attr", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cri = 9,
	calculateType = 4,
	cri_def = 12,
	defenseIgnore = 19,
	cri_dmg = 11,
	clutch = 17,
	mdef = 8,
	heal = 18,
	add_dmg = 13,
	def = 7,
	normalSkillRate = 20,
	atk = 6,
	icon = 3,
	level = 2,
	absorb = 16,
	revive = 15,
	recri = 10,
	drop_dmg = 14,
	hp = 5,
	id = 1
}
local var_0_2 = {
	"id",
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
