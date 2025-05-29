module("modules.configs.excel2json.lua_rouge_monster_rule", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	unlockType = 5,
	unlockParam = 6,
	addCollection = 3,
	rare = 2,
	desc = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
