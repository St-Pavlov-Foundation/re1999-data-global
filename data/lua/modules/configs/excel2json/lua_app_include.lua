module("modules.configs.excel2json.lua_app_include", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	path = 8,
	video = 7,
	guide = 6,
	seasonIds = 5,
	roomTheme = 10,
	heroStoryIds = 11,
	story = 4,
	chapter = 3,
	character = 2,
	id = 1,
	maxWeekWalk = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
