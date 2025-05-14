module("modules.configs.excel2json.lua_chapter_puzzle_question", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	descEn = 5,
	answer = 9,
	question = 8,
	questionTitle = 6,
	title = 2,
	questionTitleEn = 7,
	desc = 4,
	titleEn = 3,
	id = 1
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	answer = 5,
	question = 4,
	questionTitle = 3,
	title = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
