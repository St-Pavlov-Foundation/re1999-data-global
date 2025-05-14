module("modules.configs.excel2json.lua_activity146", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	openDay = 4,
	name = 5,
	preId = 3,
	interactType = 9,
	text = 6,
	photo = 8,
	id = 2,
	activityId = 1,
	bonus = 7
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
