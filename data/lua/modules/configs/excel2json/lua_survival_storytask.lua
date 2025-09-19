module("modules.configs.excel2json.lua_survival_storytask", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	failCondition = 14,
	prepose = 13,
	dropShow = 17,
	desc4 = 9,
	title = 4,
	desc3 = 8,
	desc = 6,
	desc2 = 7,
	needAccept = 12,
	eventID = 5,
	maxProgress = 11,
	group = 2,
	progressCondition = 10,
	track = 18,
	uselessCondition = 15,
	autoDrop = 16,
	step = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc3 = 4,
	desc2 = 3,
	desc4 = 5,
	title = 1,
	desc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
