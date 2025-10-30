module("modules.configs.excel2json.lua_currency", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	recoverNum = 10,
	name = 2,
	useDesc = 7,
	maxLimit = 13,
	dayRecoverNum = 12,
	headIconSign = 15,
	rare = 3,
	desc = 8,
	recoverTime = 9,
	smallIcon = 6,
	recoverLimit = 11,
	sources = 14,
	id = 1,
	icon = 5,
	highQuality = 4
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
