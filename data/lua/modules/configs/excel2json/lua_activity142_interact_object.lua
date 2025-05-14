module("modules.configs.excel2json.lua_activity142_interact_object", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	alertType = 8,
	name = 3,
	id = 2,
	effectId = 10,
	moveAudioId = 12,
	param = 5,
	showParam = 7,
	createAudioId = 11,
	alertParam = 9,
	avatar = 6,
	interactType = 4,
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
