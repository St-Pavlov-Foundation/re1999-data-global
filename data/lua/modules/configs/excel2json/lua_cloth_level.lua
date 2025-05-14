module("modules.configs.excel2json.lua_cloth_level", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	usePower1 = 14,
	passiveSkills = 12,
	usePower3 = 22,
	id = 1,
	death = 10,
	recover = 7,
	compose = 6,
	move = 5,
	skill2 = 17,
	maxPower = 3,
	cd2 = 19,
	desc = 11,
	allLimit3 = 24,
	defeat = 9,
	use = 4,
	level = 2,
	allLimit1 = 16,
	allLimit2 = 20,
	exp = 25,
	skill3 = 21,
	usePower2 = 18,
	skill1 = 13,
	cd3 = 23,
	initial = 8,
	cd1 = 15
}
local var_0_2 = {
	"id",
	"level"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
