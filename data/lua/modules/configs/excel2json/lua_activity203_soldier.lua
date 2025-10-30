module("modules.configs.excel2json.lua_activity203_soldier", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	description = 4,
	passiveSkill = 8,
	hP = 5,
	type = 2,
	name = 3,
	icon = 9,
	animation = 11,
	resource = 6,
	speed = 7,
	soldierId = 1,
	scale = 10
}
local var_0_2 = {
	"soldierId"
}
local var_0_3 = {
	description = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
