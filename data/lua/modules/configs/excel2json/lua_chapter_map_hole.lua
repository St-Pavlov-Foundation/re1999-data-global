module("modules.configs.excel2json.lua_chapter_map_hole", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 3,
	mapId = 1,
	sort = 2
}
local var_0_2 = {
	"mapId",
	"sort"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
