module("modules.configs.excel2json.lua_story_activity_open", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	part = 2,
	chapter = 1,
	labelRes = 5,
	titleEn = 4,
	title = 3,
	storyBg = 6
}
local var_0_2 = {
	"chapter",
	"part"
}
local var_0_3 = {
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
