module("modules.configs.excel2json.lua_survival_block", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	preAttrDesc = 10,
	name = 2,
	rotate = 7,
	grid = 6,
	resource = 5,
	preAttr = 9,
	subType = 4,
	copyIds = 3,
	id = 1,
	weight = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	preAttrDesc = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
