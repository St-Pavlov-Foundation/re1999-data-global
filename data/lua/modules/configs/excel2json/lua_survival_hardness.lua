module("modules.configs.excel2json.lua_survival_hardness", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 2,
	isShow = 8,
	icon = 9,
	type = 4,
	titile = 10,
	scoreRate = 12,
	extendScoreFix = 13,
	desc = 11,
	lockDesc = 14,
	subtype = 5,
	seasons = 3,
	id = 1,
	optional = 7,
	level = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	lockDesc = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
