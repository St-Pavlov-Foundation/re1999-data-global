module("modules.configs.excel2json.lua_month_card_added", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	onceBonus = 3,
	limit = 5,
	overMaxDayBonus = 6,
	days = 4,
	id = 1,
	month_id = 2
}
local var_0_2 = {
	"id"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
