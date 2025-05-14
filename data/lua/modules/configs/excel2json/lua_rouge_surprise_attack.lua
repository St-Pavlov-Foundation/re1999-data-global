module("modules.configs.excel2json.lua_rouge_surprise_attack", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	title = 2,
	hiddenRule = 4,
	ruleDesc = 5,
	tipsDesc = 6,
	id = 1,
	additionRule = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tipsDesc = 3,
	title = 1,
	ruleDesc = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
