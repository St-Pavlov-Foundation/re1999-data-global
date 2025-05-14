module("modules.configs.excel2json.lua_rogue_room", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nextRoom = 6,
	name = 2,
	layer = 5,
	type = 7,
	id = 1,
	difficulty = 4,
	nameEn = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
