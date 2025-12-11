module("modules.configs.excel2json.lua_fishing_pool", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	item = 3,
	time = 4,
	id = 1,
	weight = 2,
	share_item = 5
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
