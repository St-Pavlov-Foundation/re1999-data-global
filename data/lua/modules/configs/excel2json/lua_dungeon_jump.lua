module("modules.configs.excel2json.lua_dungeon_jump", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	isflag = 7,
	celltype = 4,
	coord = 3,
	cellspecies = 6,
	id = 1,
	cellId = 2,
	evenid = 5
}
local var_0_2 = {
	"id",
	"cellId"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
