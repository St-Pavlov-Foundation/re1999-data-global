module("modules.configs.excel2json.lua_survival_decreetask", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 3,
	failCondition = 13,
	prepose = 12,
	dropShow = 15,
	group = 2,
	progressCondition = 9,
	uselessCondition = 14,
	desc = 6,
	id = 1,
	desc2 = 8,
	needAccept = 11,
	seasons = 4,
	tag = 7,
	maxProgress = 10,
	step = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
