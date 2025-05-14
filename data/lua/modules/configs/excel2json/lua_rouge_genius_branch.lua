module("modules.configs.excel2json.lua_rouge_genius_branch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 11,
	openDesc = 8,
	isOrigin = 14,
	startView = 13,
	season = 1,
	show = 12,
	pos = 6,
	desc = 15,
	effects = 9,
	talent = 3,
	initialCollection = 10,
	name = 4,
	id = 2,
	icon = 16,
	before = 5,
	attribute = 7
}
local var_0_2 = {
	"season",
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
