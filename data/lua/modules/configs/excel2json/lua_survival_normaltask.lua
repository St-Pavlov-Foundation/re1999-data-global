module("modules.configs.excel2json.lua_survival_normaltask", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	desc = 4,
	failCondition = 12,
	prepose = 11,
	dropShow = 15,
	group = 2,
	progressCondition = 8,
	uselessCondition = 13,
	showInExplore = 7,
	track = 16,
	desc2 = 6,
	needAccept = 10,
	maxProgress = 9,
	id = 1,
	icon = 5,
	autoDrop = 14,
	step = 3
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
