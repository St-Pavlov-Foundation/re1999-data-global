module("modules.configs.excel2json.lua_special_block", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 2,
	sources = 8,
	useDesc = 3,
	duplicateItem = 11,
	age = 10,
	rare = 6,
	desc = 4,
	heroId = 9,
	id = 1,
	icon = 5,
	nameEn = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
