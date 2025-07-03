module("modules.configs.excel2json.lua_activity191_enhance", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	effects = 8,
	name = 3,
	relateItem = 6,
	relateHero = 5,
	id = 1,
	icon = 7,
	activityId = 2,
	desc = 4
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
