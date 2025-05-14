module("modules.configs.excel2json.lua_activity163_clue", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	clueName = 3,
	materialId = 6,
	clueIcon = 2,
	clueId = 1,
	clueDesc = 4,
	replaceId = 7,
	episodeId = 5
}
local var_0_2 = {
	"clueId"
}
local var_0_3 = {
	clueName = 1,
	clueDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
