module("modules.configs.excel2json.lua_survival_shelter_monster_act", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	round9 = 12,
	round4 = 7,
	round7 = 10,
	round3 = 6,
	monsterSpeed = 3,
	round6 = 9,
	round10 = 13,
	round5 = 8,
	fightId = 1,
	round8 = 11,
	monsterID = 2,
	round2 = 5,
	round1 = 4
}
local var_0_2 = {
	"fightId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
