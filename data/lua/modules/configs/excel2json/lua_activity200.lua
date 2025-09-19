module("modules.configs.excel2json.lua_activity200", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	photo2 = 9,
	name = 4,
	preId = 3,
	photo1 = 8,
	text = 5,
	id = 2,
	position = 7,
	activityId = 1,
	bonus = 6
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	text = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
