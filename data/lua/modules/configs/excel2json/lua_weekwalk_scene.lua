module("modules.configs.excel2json.lua_weekwalk_scene", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	map = 2,
	name = 6,
	buffId = 4,
	mapId = 3,
	name_en = 9,
	battleName = 8,
	typeName = 5,
	id = 1,
	icon = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	typeName = 1,
	name_en = 4,
	battleName = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
