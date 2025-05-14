module("modules.configs.excel2json.lua_insight_item", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	heroRares = 5,
	name = 2,
	useDesc = 8,
	heroRank = 6,
	desc = 9,
	effect = 11,
	rare = 4,
	expireHours = 7,
	sources = 12,
	useTitle = 10,
	id = 1,
	icon = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	useTitle = 4,
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
