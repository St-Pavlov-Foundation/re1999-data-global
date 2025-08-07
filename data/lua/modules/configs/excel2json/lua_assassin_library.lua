module("modules.configs.excel2json.lua_assassin_library", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	toastIcon = 7,
	storyId = 11,
	type = 5,
	title = 2,
	content = 3,
	unlock = 9,
	res = 6,
	talk = 10,
	id = 1,
	activityId = 4,
	detail = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	content = 2,
	title = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
