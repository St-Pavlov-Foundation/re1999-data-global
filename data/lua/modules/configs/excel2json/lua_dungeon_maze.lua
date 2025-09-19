module("modules.configs.excel2json.lua_dungeon_maze", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	dialogid = 5,
	celltype = 3,
	id = 1,
	cellId = 2,
	evenid = 4
}
local var_0_2 = {
	"id",
	"cellId"
}
local var_0_3 = {
	dialogid = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
