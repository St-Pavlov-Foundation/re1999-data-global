module("modules.configs.excel2json.lua_activity117_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content2 = 4,
	content1 = 3,
	activityId = 1,
	type = 2
}
local var_0_2 = {
	"activityId",
	"type"
}
local var_0_3 = {
	content2 = 2,
	content1 = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
