module("modules.configs.excel2json.lua_activity178_episode", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	reward = 12,
	name = 4,
	condition2 = 10,
	type = 3,
	target = 11,
	shortDesc = 6,
	condition = 9,
	desc = 7,
	mapId = 8,
	id = 2,
	longDesc = 5,
	activityId = 1
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	longDesc = 2,
	name = 1,
	shortDesc = 3,
	desc = 4
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
