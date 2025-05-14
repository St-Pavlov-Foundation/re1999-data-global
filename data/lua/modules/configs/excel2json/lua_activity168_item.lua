module("modules.configs.excel2json.lua_activity168_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemId = 2,
	name = 3,
	compostType = 5,
	type = 4,
	weight = 6,
	icon = 7,
	activityId = 1,
	desc = 8
}
local var_0_2 = {
	"activityId",
	"itemId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
