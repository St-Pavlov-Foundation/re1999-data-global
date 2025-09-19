module("modules.configs.excel2json.lua_dungeon_maze_event", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type = 2,
	desc = 3,
	evenid = 1
}
local var_0_2 = {
	"evenid"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
