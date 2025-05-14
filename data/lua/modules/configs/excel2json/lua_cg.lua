module("modules.configs.excel2json.lua_cg", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	preCgId = 9,
	name = 4,
	nameEn = 5,
	storyChapterId = 3,
	desc = 6,
	image = 8,
	episodeId = 7,
	id = 1,
	order = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
