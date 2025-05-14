module("modules.configs.excel2json.lua_trade_level_unlock", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	itemType = 7,
	name = 2,
	levelupDes = 5,
	type = 4,
	id = 1,
	icon = 3,
	sort = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	levelupDes = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
