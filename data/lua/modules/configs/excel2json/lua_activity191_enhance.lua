module("modules.configs.excel2json.lua_activity191_enhance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	relate = 8,
	name = 4,
	relateItem = 7,
	icon = 9,
	weight = 11,
	desc = 5,
	effects = 10,
	relateHero = 6,
	id = 1,
	stage = 3,
	activityId = 2
}
local var_0_2 = {
	"id",
	"activityId"
}
local var_0_3 = {
	desc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
