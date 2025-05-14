module("modules.configs.excel2json.lua_room_order_refresh", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	wholesaleRevenueWeeklyLimit = 5,
	finishLimitDaily = 3,
	wholesaleGoodsWeight = 6,
	meanwhileWholesaleNum = 4,
	qualityWeight = 2,
	level = 1
}
local var_0_2 = {
	"level"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
