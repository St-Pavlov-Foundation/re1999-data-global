module("modules.configs.excel2json.lua_activity176_dogtag", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	content4 = 6,
	content2 = 4,
	id = 2,
	content1 = 3,
	activityId = 1,
	content3 = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	content2 = 2,
	content1 = 1,
	content4 = 4,
	content3 = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
