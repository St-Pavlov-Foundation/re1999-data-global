module("modules.configs.excel2json.lua_tower_limited_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	entrance = 5,
	season = 3,
	layerId = 1,
	difficulty = 2,
	episodeId = 4
}
local var_0_2 = {
	"layerId",
	"difficulty"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
