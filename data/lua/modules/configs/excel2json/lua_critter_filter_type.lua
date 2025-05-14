module("modules.configs.excel2json.lua_critter_filter_type", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	tabIcon = 6,
	name = 2,
	tabName = 5,
	id = 1,
	filterTab = 4,
	nameEn = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	tabName = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
