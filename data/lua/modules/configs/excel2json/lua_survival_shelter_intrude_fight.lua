module("modules.configs.excel2json.lua_survival_shelter_intrude_fight", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	score = 4,
	gridType = 8,
	battleId = 3,
	smallheadicon = 9,
	name = 10,
	image = 5,
	target = 2,
	desc = 11,
	saveMonster = 12,
	destructionLevel = 13,
	model = 6,
	drop = 14,
	id = 1,
	scale = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	target = 1,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
