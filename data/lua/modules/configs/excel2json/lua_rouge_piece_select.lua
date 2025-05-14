module("modules.configs.excel2json.lua_rouge_piece_select", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	activeParam = 5,
	display = 11,
	triggerParam = 10,
	unlockParam = 3,
	id = 1,
	title = 6,
	content = 7,
	triggerType = 9,
	unlockType = 2,
	activeType = 4,
	talkDesc = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	talkDesc = 3,
	title = 1,
	content = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
