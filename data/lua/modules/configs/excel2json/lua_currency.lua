module("modules.configs.excel2json.lua_currency", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	subType = 3,
	name = 2,
	useDesc = 8,
	maxLimit = 14,
	dayRecoverNum = 13,
	headIconSign = 16,
	rare = 4,
	desc = 9,
	recoverTime = 10,
	smallIcon = 7,
	recoverLimit = 12,
	sources = 15,
	id = 1,
	icon = 6,
	recoverNum = 11,
	highQuality = 5
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
