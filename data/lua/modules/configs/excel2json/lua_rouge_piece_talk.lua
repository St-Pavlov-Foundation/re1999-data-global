module("modules.configs.excel2json.lua_rouge_piece_talk", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	title = 2,
	exitDesc = 5,
	id = 1,
	selectIds = 4,
	content = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	title = 1,
	content = 2,
	exitDesc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
