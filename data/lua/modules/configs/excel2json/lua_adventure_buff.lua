module("modules.configs.excel2json.lua_adventure_buff", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type = 6,
	name = 4,
	maxCountInMap = 8,
	skillId = 3,
	id = 1,
	icon = 2,
	rare = 7,
	desc = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
