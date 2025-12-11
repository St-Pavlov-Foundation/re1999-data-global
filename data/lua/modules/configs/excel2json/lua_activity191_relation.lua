module("modules.configs.excel2json.lua_activity191_relation", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	name = 4,
	activeNum = 7,
	levelDesc = 9,
	summon = 12,
	tagBg = 6,
	desc = 8,
	effects = 10,
	tag = 3,
	icon = 11,
	activityId = 2,
	level = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	levelDesc = 3,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
