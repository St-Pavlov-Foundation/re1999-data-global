module("modules.configs.excel2json.lua_rouge_story_list", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	stageId = 4,
	name = 7,
	levelIdDict = 6,
	id = 2,
	season = 1,
	image = 5,
	storyIdList = 3,
	desc = 8
}
local var_0_2 = {
	"season",
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
