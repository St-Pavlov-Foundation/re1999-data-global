module("modules.configs.excel2json.lua_rouge_talent_branch", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	cost = 8,
	name = 3,
	isOrigin = 9,
	before = 4,
	pos = 5,
	desc = 10,
	talent = 2,
	special = 7,
	id = 1,
	icon = 11,
	attribute = 6
}
local var_0_2 = {
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
