module("modules.configs.excel2json.lua_activity109_interact_object", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	param = 6,
	name_en = 4,
	interactType = 5,
	name = 3,
	id = 2,
	avatar = 7,
	activityId = 1,
	showParam = 8
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
