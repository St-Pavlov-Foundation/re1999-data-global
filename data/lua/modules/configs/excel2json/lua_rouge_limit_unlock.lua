module("modules.configs.excel2json.lua_rouge_limit_unlock", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	style = 4,
	unlockCost = 5,
	skillId = 3,
	id = 1,
	version = 2
}
local var_0_2 = {
	"id",
	"version"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
