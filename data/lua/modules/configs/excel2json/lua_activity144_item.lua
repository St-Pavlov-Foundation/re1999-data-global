module("modules.configs.excel2json.lua_activity144_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isStackable = 9,
	name = 2,
	useDesc = 3,
	isShow = 10,
	effect = 11,
	sources = 12,
	rare = 7,
	desc = 4,
	subType = 5,
	id = 1,
	icon = 6,
	highQuality = 8
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
