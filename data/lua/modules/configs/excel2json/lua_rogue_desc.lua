module("modules.configs.excel2json.lua_rogue_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	baseDesc = 10,
	name = 2,
	effectId = 7,
	tag3 = 5,
	tag2 = 4,
	attrDesc = 9,
	desc = 8,
	tag4 = 6,
	tag1 = 3,
	id = 1
}
local var_0_2 = {
	"id",
	"effectId"
}
local var_0_3 = {
	baseDesc = 8,
	name = 1,
	tag4 = 5,
	tag1 = 2,
	tag3 = 4,
	tag2 = 3,
	attrDesc = 7,
	desc = 6
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
