module("modules.configs.excel2json.lua_activity112", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	items = 3,
	theme2 = 12,
	themeDone2 = 14,
	theme = 11,
	themeDone = 13,
	skin = 6,
	skinOffSet = 7,
	chatheadsOffSet = 10,
	head = 5,
	storyId = 15,
	skin2OffSet = 9,
	skin2 = 8,
	id = 2,
	activityId = 1,
	bonus = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	themeDone = 3,
	themeDone2 = 4,
	theme2 = 2,
	theme = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
