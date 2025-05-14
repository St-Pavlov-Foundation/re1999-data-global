module("modules.configs.excel2json.lua_rouge_item_static_desc", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	item1_attr = 3,
	id = 1,
	item3 = 6,
	item2_attr = 5,
	item2 = 4,
	item3_attr = 7,
	item1 = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
