module("modules.configs.excel2json.lua_activity115_chapter", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 2,
	name = 3,
	ambientAudio = 6,
	name_En = 4,
	activityId = 1,
	openId = 5
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
