module("modules.configs.excel2json.lua_activity114_meeting", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	nameEng = 4,
	name = 3,
	banTurn = 10,
	tag = 11,
	events = 7,
	condition = 8,
	character = 6,
	id = 2,
	signature = 5,
	activityId = 1,
	des = 9
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	des = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
