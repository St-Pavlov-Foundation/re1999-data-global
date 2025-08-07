module("modules.configs.excel2json.lua_odyssey_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	suitId = 8,
	name = 4,
	addSkill = 9,
	type = 3,
	extraSuitCount = 10,
	rare = 2,
	desc = 5,
	id = 1,
	icon = 7,
	skillDesc = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	skillDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
