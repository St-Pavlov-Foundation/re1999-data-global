module("modules.configs.excel2json.lua_rouge_drop", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	power = 4,
	enterBag = 9,
	notOwned = 10,
	exp = 5,
	drop = 8,
	talent = 3,
	selectCount = 6,
	coin = 2,
	id = 1,
	dropCount = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
