module("modules.configs.excel2json.lua_activity115_interact_object", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	alertType = 8,
	name = 3,
	id = 2,
	param = 5,
	battleDesc = 11,
	alertParam = 9,
	showParam = 7,
	battleName = 10,
	recommendLevel = 12,
	avatar = 6,
	interactType = 4,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	battleDesc = 3,
	name = 1,
	battleName = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
