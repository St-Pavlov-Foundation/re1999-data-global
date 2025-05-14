module("modules.configs.excel2json.lua_chapter_map_element_dispatch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 8,
	id = 1,
	time = 4,
	image = 9,
	title = 7,
	unlockLineNumbers = 12,
	extraParam = 6,
	elementId = 10,
	shortType = 5,
	minCount = 2,
	maxCount = 3,
	activityId = 11
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
