module("modules.configs.excel2json.lua_activity142_chapter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	selectSprite = 6,
	name = 3,
	lockSprite = 7,
	txtColor = 4,
	id = 2,
	normalSprite = 5,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
