module("modules.configs.excel2json.lua_explore_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	icon = 6,
	name = 3,
	interactEffect = 11,
	type = 2,
	effect = 10,
	isClientStackable = 9,
	desc = 4,
	audioId = 7,
	desc2 = 5,
	id = 1,
	isStackable = 8,
	isReserve = 12
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 3,
	name = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
