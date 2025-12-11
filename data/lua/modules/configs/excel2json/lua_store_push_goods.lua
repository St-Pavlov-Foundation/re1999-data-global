module("modules.configs.excel2json.lua_store_push_goods", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	gapHours = 5,
	desc = 7,
	levelLimits = 9,
	typeId = 4,
	className = 6,
	listenerType = 2,
	listenerParam = 3,
	goodpushsId = 1,
	containedgoodsId = 8
}
local var_0_2 = {
	"goodpushsId"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
