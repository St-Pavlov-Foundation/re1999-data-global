module("modules.configs.excel2json.lua_explore_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	type = 6,
	res = 5,
	chapterId = 1,
	id = 2,
	title = 3,
	content = 7,
	desc = 4
}
local var_0_2 = {
	"chapterId",
	"id"
}
local var_0_3 = {
	title = 1,
	content = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
