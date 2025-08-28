module("modules.configs.excel2json.lua_store_charge_conditional", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 8,
	order2 = 9,
	idsStr = 11,
	bigImg3 = 7,
	conDesc = 10,
	listenerType = 2,
	listenerParam = 3,
	goodsId = 1,
	maxProgress = 4,
	bigImg2 = 6,
	bonus = 5
}
local var_0_2 = {
	"goodsId"
}
local var_0_3 = {
	conDesc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
