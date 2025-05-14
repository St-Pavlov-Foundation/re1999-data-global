module("modules.configs.excel2json.lua_equip", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isSpRefine = 11,
	name = 2,
	name_en = 3,
	skillName = 4,
	upperLimit = 17,
	desc = 13,
	isExpEquip = 10,
	strengthType = 8,
	tag = 9,
	icon = 5,
	sources = 15,
	useDesc = 14,
	skillType = 7,
	rare = 6,
	id = 1,
	canShowHandbook = 16,
	useSpRefine = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	skillName = 2,
	name = 1,
	useDesc = 4,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
