module("modules.configs.excel2json.lua_chapter_divide", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	resPageClosed = 5,
	name = 2,
	nameEn = 3,
	resPage = 4,
	chapterId = 6,
	storyId = 7,
	sectionId = 1
}
local var_0_2 = {
	"sectionId"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
