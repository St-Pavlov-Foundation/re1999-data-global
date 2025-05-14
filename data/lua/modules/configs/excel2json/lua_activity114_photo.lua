module("modules.configs.excel2json.lua_activity114_photo", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	name = 4,
	bigCg = 7,
	condition = 3,
	desc = 9,
	smallCg = 6,
	id = 2,
	features = 8,
	activityId = 1,
	nameEn = 5
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
